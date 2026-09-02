package main

import (
	"context"
	"crypto/ecdsa"
	"encoding/json"
	"errors"
	"flag"
	"fmt"
	"log"
	"math/big"
	"os"
	"strings"
	"sync"
	"time"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
)

// NetworkConfig holds Ethereum node RPC details and gas policies.
type NetworkConfig struct {
	RPCUrl            string  `json:"rpcUrl"`
	ChainID           int64   `json:"chainId"`
	MaxPriorityGwei   int64   `json:"maxPriorityGwei"`
	BaseFeeMultiplier float64 `json:"baseFeeMultiplier"`
	Confirmations     uint64  `json:"confirmations"`
}

// TransferTarget represents a recipient wallet and the amount of Wei to send.
type TransferTarget struct {
	Recipient common.Address `json:"recipient"`
	AmountWei *big.Int       `json:"amountWei"`
	Label     string         `json:"label,omitempty"`
}

// TransferReport records the telemetry and status of an executed transaction.
type TransferReport struct {
	Index        int            `json:"index"`
	Recipient    string         `json:"recipient"`
	AmountWei    *big.Int       `json:"amountWei"`
	TxHash       string         `json:"txHash"`
	Nonce        uint64         `json:"nonce"`
	GasUsed      uint64         `json:"gasUsed"`
	EffectiveFee *big.Int       `json:"effectiveFee"`
	DurationMs   int64          `json:"durationMs"`
	Status       string         `json:"status"`
	Error        string         `json:"error,omitempty"`
}

// WalletTransferEngine manages fund distribution across multiple destination wallets.
type WalletTransferEngine struct {
	client  *ethclient.Client
	config  NetworkConfig
	privKey *ecdsa.PrivateKey
	from    common.Address
	chainID *big.Int
	mu      sync.Mutex
}

// maskAddress returns a safe, anonymized representation of an Ethereum address.
func maskAddress(addr common.Address) string {
	hex := addr.Hex()
	if len(hex) < 10 {
		return "0x***"
	}
	return fmt.Sprintf("%s...%s", hex[:6], hex[len(hex)-4:])
}

// maskHash returns a safe, anonymized representation of a transaction hash.
func maskHash(hash common.Hash) string {
	hex := hash.Hex()
	if len(hex) < 12 {
		return "0x***"
	}
	return fmt.Sprintf("%s...%s", hex[:8], hex[len(hex)-6:])
}

// NewWalletTransferEngine initializes a new engine with authenticated credentials.
func NewWalletTransferEngine(ctx context.Context, rpcUrl string, privKey *ecdsa.PrivateKey, cfg NetworkConfig) (*WalletTransferEngine, error) {
	client, err := ethclient.DialContext(ctx, rpcUrl)
	if err != nil {
		return nil, fmt.Errorf("failed to dial rpc endpoint: %w", err)
	}

	fromAddress := crypto.PubkeyToAddress(privKey.PublicKey)
	chainID, err := client.NetworkID(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve chain id: %w", err)
	}

	log.Printf("🧪 [Dracula's Vial] Engine Initialized | Sender: %s | Chain ID: %s", maskAddress(fromAddress), chainID.String())

	return &WalletTransferEngine{
		client:  client,
		config:  cfg,
		privKey: privKey,
		from:    fromAddress,
		chainID: chainID,
	}, nil
}

// CheckBalance queries the sender account's current Wei balance.
func (e *WalletTransferEngine) CheckBalance(ctx context.Context) (*big.Int, error) {
	balance, err := e.client.BalanceAt(ctx, e.from, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to fetch balance: %w", err)
	}
	return balance, nil
}

// ExecuteTransfer signs, transmits, and confirms an EIP-1559 transaction to a recipient.
func (e *WalletTransferEngine) ExecuteTransfer(ctx context.Context, target TransferTarget, nonce uint64) (*TransferReport, error) {
	startTime := time.Now()
	report := &TransferReport{
		Recipient: maskAddress(target.Recipient),
		AmountWei: target.AmountWei,
		Nonce:     nonce,
		Status:    "PENDING",
	}

	// Dynamic tip cap (MaxPriorityFeePerGas)
	tipCapGwei := big.NewInt(e.config.MaxPriorityGwei)
	tipCap := new(big.Int).Mul(tipCapGwei, big.NewInt(1e9))

	// Fetch latest block header for EIP-1559 base fee
	header, err := e.client.HeaderByNumber(ctx, nil)
	if err != nil {
		report.Status = "FAILED"
		report.Error = fmt.Sprintf("header fetch error: %v", err)
		return report, err
	}

	// feeCap = (BaseFee * multiplier) + tipCap
	mult := big.NewFloat(e.config.BaseFeeMultiplier)
	baseFeeFloat := new(big.Float).SetInt(header.BaseFee)
	scaledBaseFeeFloat := new(big.Float).Mul(baseFeeFloat, mult)
	scaledBaseFee, _ := scaledBaseFeeFloat.Int(nil)
	feeCap := new(big.Int).Add(scaledBaseFee, tipCap)

	gasLimit := uint64(21000)

	// Create dynamic fee transaction payload
	txData := &types.DynamicFeeTx{
		ChainID:   e.chainID,
		Nonce:     nonce,
		GasTipCap: tipCap,
		GasFeeCap: feeCap,
		Gas:       gasLimit,
		To:        &target.Recipient,
		Value:     target.AmountWei,
		Data:      nil,
	}

	tx := types.NewTx(txData)
	signer := types.LatestSignerForChainID(e.chainID)
	signedTx, err := types.SignTx(tx, signer, e.privKey)
	if err != nil {
		report.Status = "SIGNING_FAILED"
		report.Error = err.Error()
		return report, err
	}

	// Broadcast transaction to Ethereum mempool
	if err := e.client.SendTransaction(ctx, signedTx); err != nil {
		report.Status = "BROADCAST_FAILED"
		report.Error = err.Error()
		return report, err
	}

	report.TxHash = maskHash(signedTx.Hash())
	log.Printf("🚀 Broadcasted Tx: %s -> Target: %s (Nonce: %d, Value: %s Wei)",
		maskHash(signedTx.Hash()), maskAddress(target.Recipient), nonce, target.AmountWei.String())

	// Wait for inclusion receipt
	receipt, err := e.waitForReceipt(ctx, signedTx.Hash())
	if err != nil {
		report.Status = "RECEIPT_TIMEOUT"
		report.Error = err.Error()
		return report, err
	}

	report.GasUsed = receipt.GasUsed
	report.EffectiveFee = receipt.EffectiveGasPrice
	report.DurationMs = time.Since(startTime).Milliseconds()

	if receipt.Status == types.ReceiptStatusSuccessful {
		report.Status = "SUCCESS"
		log.Printf("✔ Tx Confirmed in block #%s | Gas Used: %d", receipt.BlockNumber.String(), receipt.GasUsed)
	} else {
		report.Status = "REVERTED"
		report.Error = "transaction execution reverted on-chain"
		return report, errors.New(report.Error)
	}

	return report, nil
}

// DistributeFunds iterates through targets and executes sequential fund transfers.
func (e *WalletTransferEngine) DistributeFunds(ctx context.Context, targets []TransferTarget) ([]*TransferReport, error) {
	e.mu.Lock()
	defer e.mu.Unlock()

	nonce, err := e.client.PendingNonceAt(ctx, e.from)
	if err != nil {
		return nil, fmt.Errorf("failed to fetch starting nonce: %w", err)
	}

	var reports []*TransferReport
	for i, target := range targets {
		log.Printf("📦 Processing Transfer [%d/%d] to %s (%s)...", i+1, len(targets), maskAddress(target.Recipient), target.Label)
		report, err := e.ExecuteTransfer(ctx, target, nonce)
		report.Index = i + 1
		reports = append(reports, report)

		if err != nil {
			log.Printf("❌ Failed transfer #%d: %v", i+1, err)
			return reports, fmt.Errorf("aborting batch at index %d: %w", i, err)
		}

		nonce++
		time.Sleep(500 * time.Millisecond)
	}

	return reports, nil
}

// waitForReceipt polls until transaction is mined or timeout expires.
func (e *WalletTransferEngine) waitForReceipt(ctx context.Context, txHash common.Hash) (*types.Receipt, error) {
	ticker := time.NewTicker(1 * time.Second)
	defer ticker.Stop()

	timeout := time.After(90 * time.Second)
	for {
		select {
		case <-ctx.Done():
			return nil, ctx.Err()
		case <-timeout:
			return nil, fmt.Errorf("receipt polling timed out for tx %s", maskHash(txHash))
		case <-ticker.C:
			receipt, err := e.client.TransactionReceipt(ctx, txHash)
			if err == nil && receipt != nil {
				return receipt, nil
			}
		}
	}
}

func main() {
	rpcEnv := os.Getenv("ETH_RPC_URL")
	if rpcEnv == "" {
		rpcEnv = "https://mainnet.infura.io/v3/YOUR_API_KEY"
	}
	rpcFlag := flag.String("rpc", rpcEnv, "Ethereum RPC Endpoint")
	flag.Parse()

	// Load private key safely from environment, or generate an ephemeral in-memory key
	var privKey *ecdsa.PrivateKey
	keyEnv := os.Getenv("ETH_PRIVATE_KEY")
	if keyEnv != "" {
		cleanKey := strings.TrimPrefix(keyEnv, "0x")
		k, err := crypto.HexToECDSA(cleanKey)
		if err != nil {
			log.Fatalf("❌ Invalid ETH_PRIVATE_KEY: %v", err)
		}
		privKey = k
	} else {
		// Generate an ephemeral random in-memory key (no hardcoded credentials)
		k, err := crypto.GenerateKey()
		if err != nil {
			log.Fatalf("❌ Key generation failed: %v", err)
		}
		privKey = k
		log.Println("🔑 Using ephemeral in-memory signing credentials (set ETH_PRIVATE_KEY for live use)")
	}

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Minute)
	defer cancel()

	config := NetworkConfig{
		RPCUrl:            *rpcFlag,
		ChainID:           1, // Ethereum Mainnet / Target Network
		MaxPriorityGwei:   2,
		BaseFeeMultiplier: 1.5,
		Confirmations:     1,
	}

	engine, err := NewWalletTransferEngine(ctx, *rpcFlag, privKey, config)
	if err != nil {
		log.Fatalf("❌ Initialization error: %v", err)
	}

	// Dynamically derive anonymous recipient target addresses
	targets := []TransferTarget{
		{
			Recipient: common.BytesToAddress(crypto.Keccak256([]byte("target-treasury-reserve"))[:20]),
			AmountWei: big.NewInt(50000000000000000), // 0.05 ETH
			Label:     "Treasury Reserve",
		},
		{
			Recipient: common.BytesToAddress(crypto.Keccak256([]byte("target-staking-node-01"))[:20]),
			AmountWei: big.NewInt(25000000000000000), // 0.025 ETH
			Label:     "Staking Node 01",
		},
		{
			Recipient: common.BytesToAddress(crypto.Keccak256([]byte("target-operations-buffer"))[:20]),
			AmountWei: big.NewInt(10000000000000000), // 0.01 ETH
			Label:     "Operations Buffer",
		},
	}

	fmt.Println("==================================================")
	fmt.Printf("🧪 [Dracula's Vial] Starting Distribution: %d Anonymous Targets\n", len(targets))
	fmt.Println("==================================================")

	reports, err := engine.DistributeFunds(ctx, targets)
	if err != nil {
		log.Printf("⚠ Pipeline halted: %v", err)
	}

	// Output structured JSON report
	summaryJSON, _ := json.MarshalIndent(reports, "", "  ")
	fmt.Println("\n📊 Distribution Telemetry Report:")
	fmt.Println(string(summaryJSON))
}
