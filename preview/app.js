// ==========================================================================
// DRACULA'S VIAL — 7 CHROMATIC ELIXIR THEMES & LIVE COLOR LAB
// ==========================================================================

const COLOR_CONFIG = [
  { id: 'purple', varName: '--drac-purple', label: 'Keywords & Control', role: 'if, return, func, package, defer, range', defaultHex: '#bd93f9' },
  { id: 'cyan', varName: '--drac-cyan', label: 'Functions & Methods', role: 'DistributeFunds(), ExecuteTransfer(), maskAddress()', defaultHex: '#8be9fd' },
  { id: 'orange', varName: '--drac-orange', label: 'Strings & Text', role: '"0x71a4...98b2", "Treasury Reserve"', defaultHex: '#ffb86c' },
  { id: 'green', varName: '--drac-green', label: 'Types & Structs', role: 'WalletTransferEngine, TransferTarget, big.Int', defaultHex: '#50fa7b' },
  { id: 'yellow', varName: '--drac-yellow', label: 'Numbers & Booleans', role: '21000, 50000000000000000, true, nil', defaultHex: '#f1fa8c' },
  { id: 'pink', varName: '--drac-pink', label: 'Fields & Properties', role: 'Recipient, AmountWei, TxHash, Nonce', defaultHex: '#ff79c6' },
  { id: 'tangerine', varName: '--drac-tangerine', label: 'Parameters & Tags', role: 'ctx, targets, nonce, `json:"amountWei"`', defaultHex: '#ff9e64' },
  { id: 'comment', varName: '--drac-comment', label: 'Comments & Docs', role: '// ExecuteTransfer signs, transmits...', defaultHex: '#68759e' },
  { id: 'bg', varName: '--drac-bg', label: 'Editor Background', role: 'Main coding canvas surface', defaultHex: '#21222c' },
  { id: 'bgDarker', varName: '--drac-bg-darker', label: 'Sidebar & Panels', role: 'Sidebar, activity bar, terminal', defaultHex: '#191a21' }
];

const PRESETS = {
  'dracula-chromatic': {
    name: "Dracula's Vial - Chromatic (Rich Full-Spectrum)",
    badge: 'Chromatic Elixir',
    colors: {
      purple: '#bd93f9',
      cyan: '#8be9fd',
      orange: '#ffb86c',
      green: '#50fa7b',
      yellow: '#f1fa8c',
      pink: '#ff79c6',
      tangerine: '#ff9e64',
      comment: '#68759e',
      bg: '#21222c',
      bgDarker: '#191a21'
    }
  },
  'dracula-triad': {
    name: "Dracula's Vial - Pure Triad (Cyan • Purple • Orange)",
    badge: 'Pure Triad',
    colors: {
      purple: '#bd93f9',
      cyan: '#8be9fd',
      orange: '#ffb86c',
      green: '#8be9fd',
      yellow: '#ffb86c',
      pink: '#ffb86c',
      tangerine: '#ffb86c',
      comment: '#68759e',
      bg: '#21222c',
      bgDarker: '#191a21'
    }
  },
  'dracula-neon-synth': {
    name: "Dracula's Vial - Neon Synth (Hot Pink • Cyan • Violet)",
    badge: 'Neon Synth',
    colors: {
      purple: '#ff2a85',
      cyan: '#00e5ff',
      orange: '#ff6b35',
      green: '#05ffa1',
      yellow: '#ffe600',
      pink: '#c77dff',
      tangerine: '#ff6b35',
      comment: '#636987',
      bg: '#161824',
      bgDarker: '#12131c'
    }
  },
  'dracula-deep-abyss': {
    name: "Dracula's Vial - Deep Abyss (Oceanic Bioluminescence)",
    badge: 'Deep Abyss',
    colors: {
      purple: '#9b5de5',
      cyan: '#00f0ff',
      orange: '#ff577f',
      green: '#00f5d4',
      yellow: '#fee440',
      pink: '#f15bb5',
      tangerine: '#ff758f',
      comment: '#4d5b75',
      bg: '#0e1017',
      bgDarker: '#080a0f'
    }
  },
  'dracula-ice-fire': {
    name: "Dracula's Vial - Ice & Fire (Glacial Cyan & Purple Flame)",
    badge: 'Ice & Fire',
    colors: {
      purple: '#9254de',
      cyan: '#00d2ff',
      orange: '#ff7a45',
      green: '#36cfc9',
      yellow: '#ffc53d',
      pink: '#f759ab',
      tangerine: '#ffa940',
      comment: '#4d6b8a',
      bg: '#0f141d',
      bgDarker: '#080c12'
    }
  },
  'dracula-galactic-plasma': {
    name: "Dracula's Vial - Galactic Plasma (Plasma Violet & Solar)",
    badge: 'Galactic Plasma',
    colors: {
      purple: '#c084fc',
      cyan: '#22d3ee',
      orange: '#f472b6',
      green: '#34d399',
      yellow: '#fbbf24',
      pink: '#e879f9',
      tangerine: '#fb923c',
      comment: '#5e638c',
      bg: '#111222',
      bgDarker: '#0a0b16'
    }
  },
  'dracula-cyber-lavender': {
    name: "Dracula's Vial - Cyber Lavender (Pastel Cyber)",
    badge: 'Cyber Lavender',
    colors: {
      purple: '#d8b4fe',
      cyan: '#67e8f9',
      orange: '#fda4af',
      green: '#86efac',
      yellow: '#fef08a',
      pink: '#e9d5ff',
      tangerine: '#fbcfe8',
      comment: '#6b6f8a',
      bg: '#151622',
      bgDarker: '#0f101a'
    }
  }
};

const CODE_SAMPLES = {
  go: {
    filename: 'transfer.go',
    path: 'samples/transfer.go',
    lang: 'Go',
    code: `package <span class="syn-cyan">main</span>

<span class="syn-purple">import</span> (
    <span class="syn-orange">"context"</span>
    <span class="syn-orange">"crypto/ecdsa"</span>
    <span class="syn-orange">"fmt"</span>
    <span class="syn-orange">"math/big"</span>
    <span class="syn-orange">"time"</span>

    <span class="syn-orange">"github.com/ethereum/go-ethereum/common"</span>
    <span class="syn-orange">"github.com/ethereum/go-ethereum/core/types"</span>
    <span class="syn-orange">"github.com/ethereum/go-ethereum/crypto"</span>
    <span class="syn-orange">"github.com/ethereum/go-ethereum/ethclient"</span>
)

<span class="syn-slate">// TransferTarget represents an anonymized recipient wallet and amount.</span>
<span class="syn-pink">type</span> <span class="syn-green syn-italic">TransferTarget</span> <span class="syn-pink">struct</span> {
    <span class="syn-pink">Recipient</span> <span class="syn-green">common.Address</span> <span class="syn-tangerine">\`json:"recipient"\`</span>
    <span class="syn-pink">AmountWei</span> *<span class="syn-green">big.Int</span>       <span class="syn-tangerine">\`json:"amountWei"\`</span>
    <span class="syn-pink">Label</span>     <span class="syn-green">string</span>         <span class="syn-tangerine">\`json:"label,omitempty"\`</span>
}

<span class="syn-slate">// WalletTransferEngine manages fund distribution across multiple destination wallets.</span>
<span class="syn-pink">type</span> <span class="syn-green syn-italic">WalletTransferEngine</span> <span class="syn-pink">struct</span> {
    <span class="syn-pink">client</span>  *<span class="syn-green">ethclient.Client</span>
    <span class="syn-pink">privKey</span> *<span class="syn-green">ecdsa.PrivateKey</span>
    <span class="syn-pink">from</span>    <span class="syn-green">common.Address</span>
    <span class="syn-pink">chainID</span> *<span class="syn-green">big.Int</span>
}

<span class="syn-slate">// maskAddress returns an anonymized representation of a public wallet.</span>
<span class="syn-purple">func</span> <span class="syn-cyan">maskAddress</span>(<span class="syn-tangerine">addr</span> <span class="syn-green">common.Address</span>) <span class="syn-green">string</span> {
    <span class="syn-fg">hex</span> := <span class="syn-tangerine">addr</span>.<span class="syn-cyan">Hex</span>()
    <span class="syn-purple">return</span> <span class="syn-green">fmt</span>.<span class="syn-cyan">Sprintf</span>(<span class="syn-orange">"%s...%s"</span>, <span class="syn-fg">hex</span>[:<span class="syn-yellow">6</span>], <span class="syn-fg">hex</span>[<span class="syn-cyan">len</span>(<span class="syn-fg">hex</span>)-<span class="syn-yellow">4</span>:])
}

<span class="syn-slate">// DistributeFunds iterates through targets and executes sequential fund transfers.</span>
<span class="syn-purple">func</span> (<span class="syn-tangerine">e</span> *<span class="syn-green">WalletTransferEngine</span>) <span class="syn-cyan">DistributeFunds</span>(<span class="syn-tangerine">ctx</span> <span class="syn-green">context.Context</span>, <span class="syn-tangerine">targets</span> []<span class="syn-green">TransferTarget</span>) ([]*<span class="syn-green">TransferReport</span>, <span class="syn-green">error</span>) {
    <span class="syn-fg">nonce</span>, <span class="syn-fg">err</span> := <span class="syn-tangerine">e</span>.<span class="syn-pink">client</span>.<span class="syn-cyan">PendingNonceAt</span>(<span class="syn-tangerine">ctx</span>, <span class="syn-tangerine">e</span>.<span class="syn-pink">from</span>)
    <span class="syn-purple">if</span> <span class="syn-fg">err</span> != <span class="syn-yellow">nil</span> {
        <span class="syn-purple">return</span> <span class="syn-yellow">nil</span>, <span class="syn-green">fmt</span>.<span class="syn-cyan">Errorf</span>(<span class="syn-orange">"failed to fetch nonce: %w"</span>, <span class="syn-fg">err</span>)
    }

    <span class="syn-purple">var</span> <span class="syn-fg">reports</span> []*<span class="syn-green">TransferReport</span>
    <span class="syn-purple">for</span> <span class="syn-fg">i</span>, <span class="syn-fg">target</span> := <span class="syn-purple">range</span> <span class="syn-tangerine">targets</span> {
        <span class="syn-fg">report</span>, <span class="syn-fg">err</span> := <span class="syn-tangerine">e</span>.<span class="syn-cyan">ExecuteTransfer</span>(<span class="syn-tangerine">ctx</span>, <span class="syn-fg">target</span>, <span class="syn-fg">nonce</span>)
        <span class="syn-purple">if</span> <span class="syn-fg">err</span> != <span class="syn-yellow">nil</span> {
            <span class="syn-purple">return</span> <span class="syn-fg">reports</span>, <span class="syn-green">fmt</span>.<span class="syn-cyan">Errorf</span>(<span class="syn-orange">"transfer failed at index %d: %w"</span>, <span class="syn-fg">i</span>, <span class="syn-fg">err</span>)
        }
        <span class="syn-fg">reports</span> = <span class="syn-cyan">append</span>(<span class="syn-fg">reports</span>, <span class="syn-fg">report</span>)
        <span class="syn-fg">nonce</span>++
    }

    <span class="syn-purple">return</span> <span class="syn-fg">reports</span>, <span class="syn-yellow">nil</span>
}

<span class="syn-slate">// ExecuteTransfer signs, transmits, and confirms an EIP-1559 transaction.</span>
<span class="syn-purple">func</span> (<span class="syn-tangerine">e</span> *<span class="syn-green">WalletTransferEngine</span>) <span class="syn-cyan">ExecuteTransfer</span>(<span class="syn-tangerine">ctx</span> <span class="syn-green">context.Context</span>, <span class="syn-tangerine">target</span> <span class="syn-green">TransferTarget</span>, <span class="syn-tangerine">nonce</span> <span class="syn-green">uint64</span>) (*<span class="syn-green">TransferReport</span>, <span class="syn-green">error</span>) {
    <span class="syn-fg">tipCap</span>, <span class="syn-fg">_</span> := <span class="syn-tangerine">e</span>.<span class="syn-pink">client</span>.<span class="syn-cyan">SuggestGasTipCap</span>(<span class="syn-tangerine">ctx</span>)
    <span class="syn-fg">head</span>, <span class="syn-fg">_</span>   := <span class="syn-tangerine">e</span>.<span class="syn-pink">client</span>.<span class="syn-cyan">HeaderByNumber</span>(<span class="syn-tangerine">ctx</span>, <span class="syn-yellow">nil</span>)
    <span class="syn-fg">feeCap</span>    := <span class="syn-green">new</span>(<span class="syn-green">big.Int</span>).<span class="syn-cyan">Add</span>(<span class="syn-green">new</span>(<span class="syn-green">big.Int</span>).<span class="syn-cyan">Mul</span>(<span class="syn-fg">head</span>.<span class="syn-pink">BaseFee</span>, <span class="syn-green">big</span>.<span class="syn-cyan">NewInt</span>(<span class="syn-yellow">2</span>)), <span class="syn-fg">tipCap</span>)

    <span class="syn-fg">txData</span> := &<span class="syn-green">types.DynamicFeeTx</span>{
        <span class="syn-pink">ChainID</span>:   <span class="syn-tangerine">e</span>.<span class="syn-pink">chainID</span>,
        <span class="syn-pink">Nonce</span>:     <span class="syn-tangerine">nonce</span>,
        <span class="syn-pink">GasTipCap</span>: <span class="syn-fg">tipCap</span>,
        <span class="syn-pink">GasFeeCap</span>: <span class="syn-fg">feeCap</span>,
        <span class="syn-pink">Gas</span>:       <span class="syn-yellow">21000</span>,
        <span class="syn-pink">To</span>:        &<span class="syn-tangerine">target</span>.<span class="syn-pink">Recipient</span>,
        <span class="syn-pink">Value</span>:     <span class="syn-tangerine">target</span>.<span class="syn-pink">AmountWei</span>,
    }

    <span class="syn-fg">tx</span> := <span class="syn-green">types</span>.<span class="syn-cyan">NewTx</span>(<span class="syn-fg">txData</span>)
    <span class="syn-fg">signer</span> := <span class="syn-green">types</span>.<span class="syn-cyan">LatestSignerForChainID</span>(<span class="syn-tangerine">e</span>.<span class="syn-pink">chainID</span>)
    <span class="syn-fg">signedTx</span>, <span class="syn-fg">err</span> := <span class="syn-green">types</span>.<span class="syn-cyan">SignTx</span>(<span class="syn-fg">tx</span>, <span class="syn-fg">signer</span>, <span class="syn-tangerine">e</span>.<span class="syn-pink">privKey</span>)
    <span class="syn-purple">if</span> <span class="syn-fg">err</span> != <span class="syn-yellow">nil</span> {
        <span class="syn-purple">return</span> <span class="syn-yellow">nil</span>, <span class="syn-green">fmt</span>.<span class="syn-cyan">Errorf</span>(<span class="syn-orange">"signing error: %w"</span>, <span class="syn-fg">err</span>)
    }

    <span class="syn-purple">if</span> <span class="syn-fg">err</span> := <span class="syn-tangerine">e</span>.<span class="syn-pink">client</span>.<span class="syn-cyan">SendTransaction</span>(<span class="syn-tangerine">ctx</span>, <span class="syn-fg">signedTx</span>); <span class="syn-fg">err</span> != <span class="syn-yellow">nil</span> {
        <span class="syn-purple">return</span> <span class="syn-yellow">nil</span>, <span class="syn-green">fmt</span>.<span class="syn-cyan">Errorf</span>(<span class="syn-orange">"broadcast failed: %w"</span>, <span class="syn-fg">err</span>)
    }

    <span class="syn-purple">return</span> &<span class="syn-green">TransferReport</span>{
        <span class="syn-pink">Recipient</span>: <span class="syn-cyan">maskAddress</span>(<span class="syn-tangerine">target</span>.<span class="syn-pink">Recipient</span>),
        <span class="syn-pink">AmountWei</span>: <span class="syn-tangerine">target</span>.<span class="syn-pink">AmountWei</span>,
        <span class="syn-pink">TxHash</span>:    <span class="syn-cyan">maskHash</span>(<span class="syn-fg">signedTx</span>.<span class="syn-cyan">Hash</span>()),
        <span class="syn-pink">Nonce</span>:     <span class="syn-tangerine">nonce</span>,
        <span class="syn-pink">Status</span>:    <span class="syn-orange">"SUCCESS"</span>,
    }, <span class="syn-yellow">nil</span>
}`
  },

  typescript: {
    filename: 'app.tsx',
    path: 'samples/app.tsx',
    lang: 'TypeScript',
    code: `<span class="syn-purple">import</span> <span class="syn-cyan">React</span>, { <span class="syn-cyan">useState</span>, <span class="syn-cyan">useEffect</span>, <span class="syn-cyan">useMemo</span>, <span class="syn-cyan">useCallback</span> } <span class="syn-purple">from</span> <span class="syn-orange">'react'</span>;

<span class="syn-pink">interface</span> <span class="syn-green syn-italic">VialMetric</span> {
  <span class="syn-pink">id</span>: <span class="syn-green">string</span>;
  <span class="syn-pink">timestamp</span>: <span class="syn-green">number</span>;
  <span class="syn-pink">label</span>: <span class="syn-green">string</span>;
  <span class="syn-pink">value</span>: <span class="syn-green">number</span>;
  <span class="syn-pink">status</span>: <span class="syn-orange">'healthy'</span> | <span class="syn-orange">'warning'</span> | <span class="syn-orange">'critical'</span>;
  <span class="syn-pink">tags</span>: <span class="syn-green">string</span>[];
}

<span class="syn-pink">interface</span> <span class="syn-green syn-italic">DashboardProps</span> {
  <span class="syn-pink">title</span>: <span class="syn-green">string</span>;
  <span class="syn-pink">refreshIntervalMs</span>?: <span class="syn-green">number</span>;
  <span class="syn-pink">onAlertTriggered</span>?: (<span class="syn-tangerine">alertId</span>: <span class="syn-green">string</span>, <span class="syn-tangerine">level</span>: <span class="syn-green">string</span>) => <span class="syn-green">void</span>;
}

<span class="syn-purple">export const</span> <span class="syn-cyan">DraculaVialDashboard</span>: <span class="syn-green">React.FC</span>&lt;<span class="syn-green">DashboardProps</span>&gt; = ({
  <span class="syn-tangerine">title</span>,
  <span class="syn-tangerine">refreshIntervalMs</span> = <span class="syn-yellow">3000</span>,
  <span class="syn-tangerine">onAlertTriggered</span>,
}) => {
  <span class="syn-purple">const</span> [<span class="syn-fg">metrics</span>, <span class="syn-cyan">setMetrics</span>] = <span class="syn-cyan">useState</span>&lt;<span class="syn-green">VialMetric</span>[]&gt;([]);
  <span class="syn-purple">const</span> [<span class="syn-fg">filterTag</span>, <span class="syn-cyan">setFilterTag</span>] = <span class="syn-cyan">useState</span>&lt;<span class="syn-green">string</span>&gt;(<span class="syn-orange">'all'</span>);
  <span class="syn-purple">const</span> [<span class="syn-fg">isLoading</span>, <span class="syn-cyan">setIsLoading</span>] = <span class="syn-cyan">useState</span>&lt;<span class="syn-green">boolean</span>&gt;(<span class="syn-yellow">true</span>);

  <span class="syn-slate">// Fetch elixir telemetry from WebSocket endpoint</span>
  <span class="syn-purple">const</span> <span class="syn-cyan">fetchTelemetry</span> = <span class="syn-cyan">useCallback</span>(<span class="syn-purple">async</span> () => {
    <span class="syn-purple">try</span> {
      <span class="syn-cyan">setIsLoading</span>(<span class="syn-yellow">true</span>);
      <span class="syn-purple">const</span> <span class="syn-fg">response</span> = <span class="syn-purple">await</span> <span class="syn-cyan">fetch</span>(<span class="syn-orange">'/api/v1/vial/telemetry'</span>);
      <span class="syn-purple">const</span> <span class="syn-fg">data</span>: <span class="syn-green">VialMetric</span>[] = <span class="syn-purple">await</span> <span class="syn-fg">response</span>.<span class="syn-cyan">json</span>();
      <span class="syn-cyan">setMetrics</span>(<span class="syn-fg">data</span>);
    } <span class="syn-purple">catch</span> (<span class="syn-tangerine">error</span>) {
      <span class="syn-green">console</span>.<span class="syn-cyan">error</span>(<span class="syn-orange">'Failed to stream metrics:'</span>, <span class="syn-fg">error</span>);
    } <span class="syn-purple">finally</span> {
      <span class="syn-cyan">setIsLoading</span>(<span class="syn-yellow">false</span>);
    }
  }, []);

  <span class="syn-purple">return</span> (
    &lt;<span class="syn-cyan">div</span> <span class="syn-tangerine">className</span>=<span class="syn-orange">"dashboard-container"</span> <span class="syn-tangerine">data-testid</span>=<span class="syn-orange">"telemetry-root"</span>&gt;
      &lt;<span class="syn-cyan">header</span> <span class="syn-tangerine">className</span>=<span class="syn-orange">"dashboard-header flex items-center justify-between"</span>&gt;
        &lt;<span class="syn-cyan">h1</span> <span class="syn-tangerine">className</span>=<span class="syn-orange">"text-xl font-bold tracking-tight text-cyan-400"</span>&gt;{<span class="syn-fg">title</span>}&lt;/<span class="syn-cyan">h1</span>&gt;
        &lt;<span class="syn-cyan">div</span> <span class="syn-tangerine">className</span>=<span class="syn-orange">"badge-group flex gap-2"</span>&gt;
          &lt;<span class="syn-cyan">span</span> <span class="syn-tangerine">className</span>=<span class="syn-orange">"badge badge-purple"</span>&gt;Live Elixirs: {<span class="syn-fg">metrics</span>.<span class="syn-pink">length</span>}&lt;/<span class="syn-cyan">span</span>&gt;
        &lt;/<span class="syn-cyan">div</span>&gt;
      &lt;/<span class="syn-cyan">header</span>&gt;
    &lt;/<span class="syn-cyan">div</span>&gt;
  );
};`
  },

  python: {
    filename: 'analysis.py',
    path: 'samples/analysis.py',
    lang: 'Python',
    code: `<span class="syn-slate">"""
Dracula's Vial algorithmic execution optimizer.
"""</span>

<span class="syn-purple">import</span> <span class="syn-cyan">asyncio</span>
<span class="syn-purple">from</span> <span class="syn-cyan">dataclasses</span> <span class="syn-purple">import</span> <span class="syn-cyan">dataclass</span>, <span class="syn-cyan">field</span>
<span class="syn-purple">from</span> <span class="syn-cyan">typing</span> <span class="syn-purple">import</span> <span class="syn-green">Dict</span>, <span class="syn-green">List</span>, <span class="syn-green">Optional</span>, <span class="syn-green">Tuple</span>
<span class="syn-purple">import</span> <span class="syn-cyan">numpy</span> <span class="syn-purple">as</span> <span class="syn-fg">np</span>


<span class="syn-purple">@dataclass</span>
<span class="syn-purple">class</span> <span class="syn-green syn-italic">VialSnapshot</span>:
    <span class="syn-pink">symbol</span>: <span class="syn-green">str</span>
    <span class="syn-pink">timestamp_ns</span>: <span class="syn-green">int</span>
    <span class="syn-pink">bids</span>: <span class="syn-green">List</span>[<span class="syn-green">Tuple</span>[<span class="syn-green">float</span>, <span class="syn-green">float</span>]] = <span class="syn-cyan">field</span>(<span class="syn-tangerine">default_factory</span>=<span class="syn-green">list</span>)
    <span class="syn-pink">asks</span>: <span class="syn-green">List</span>[<span class="syn-green">Tuple</span>[<span class="syn-green">float</span>, <span class="syn-green">float</span>]] = <span class="syn-cyan">field</span>(<span class="syn-tangerine">default_factory</span>=<span class="syn-green">list</span>)
    <span class="syn-pink">mid_price</span>: <span class="syn-green">float</span> = <span class="syn-yellow">0.0</span>

    <span class="syn-purple">def</span> <span class="syn-cyan">compute_spread</span>(<span class="syn-tangerine">self</span>) -> <span class="syn-green">float</span>:
        <span class="syn-slate">"""Calculate top of book bid-ask spread in basis points."""</span>
        <span class="syn-purple">if not</span> <span class="syn-tangerine">self</span>.<span class="syn-pink">bids</span> <span class="syn-purple">or not</span> <span class="syn-tangerine">self</span>.<span class="syn-pink">asks</span>:
            <span class="syn-purple">return</span> <span class="syn-yellow">0.0</span>
        <span class="syn-fg">best_bid</span> = <span class="syn-tangerine">self</span>.<span class="syn-pink">bids</span>[<span class="syn-yellow">0</span>][<span class="syn-yellow">0</span>]
        <span class="syn-fg">best_ask</span> = <span class="syn-tangerine">self</span>.<span class="syn-pink">asks</span>[<span class="syn-yellow">0</span>][<span class="syn-yellow">0</span>]
        <span class="syn-purple">return</span> ((<span class="syn-fg">best_ask</span> - <span class="syn-fg">best_bid</span>) / <span class="syn-tangerine">self</span>.<span class="syn-pink">mid_price</span>) * <span class="syn-yellow">10000.0</span>


<span class="syn-purple">class</span> <span class="syn-green syn-italic">VialVolatilityEngine</span>:
    <span class="syn-slate">"""Predictive volatility engine using stochastic volatility models."""</span>

    <span class="syn-purple">def</span> <span class="syn-cyan">__init__</span>(<span class="syn-tangerine">self</span>, <span class="syn-tangerine">decay_rate</span>: <span class="syn-green">float</span> = <span class="syn-yellow">0.94</span>, <span class="syn-tangerine">window_size</span>: <span class="syn-green">int</span> = <span class="syn-yellow">120</span>):
        <span class="syn-tangerine">self</span>.<span class="syn-pink">decay_rate</span> = <span class="syn-tangerine">decay_rate</span>
        <span class="syn-tangerine">self</span>.<span class="syn-pink">window_size</span> = <span class="syn-tangerine">window_size</span>
        <span class="syn-tangerine">self</span>.<span class="syn-pink">_history</span>: <span class="syn-green">List</span>[<span class="syn-green">float</span>] = []

    <span class="syn-purple">async def</span> <span class="syn-cyan">update_tick</span>(<span class="syn-tangerine">self</span>, <span class="syn-tangerine">snapshot</span>: <span class="syn-green">VialSnapshot</span>) -> <span class="syn-green">Dict</span>[<span class="syn-green">str</span>, <span class="syn-green">float</span>]:
        <span class="syn-slate">"""Ingest new tick and compute updated metrics."""</span>
        <span class="syn-tangerine">self</span>.<span class="syn-pink">_history</span>.<span class="syn-cyan">append</span>(<span class="syn-tangerine">snapshot</span>.<span class="syn-pink">mid_price</span>)
        <span class="syn-purple">if</span> <span class="syn-cyan">len</span>(<span class="syn-tangerine">self</span>.<span class="syn-pink">_history</span>) > <span class="syn-tangerine">self</span>.<span class="syn-pink">window_size</span>:
            <span class="syn-tangerine">self</span>.<span class="syn-pink">_history</span>.<span class="syn-cyan">pop</span>(<span class="syn-yellow">0</span>)

        <span class="syn-fg">prices</span> = <span class="syn-fg">np</span>.<span class="syn-cyan">array</span>(<span class="syn-tangerine">self</span>.<span class="syn-pink">_history</span>)
        <span class="syn-fg">returns</span> = <span class="syn-fg">np</span>.<span class="syn-cyan">diff</span>(<span class="syn-fg">np</span>.<span class="syn-cyan">log</span>(<span class="syn-fg">prices</span>)) <span class="syn-purple">if</span> <span class="syn-cyan">len</span>(<span class="syn-fg">prices</span>) > <span class="syn-yellow">1</span> <span class="syn-purple">else</span> <span class="syn-fg">np</span>.<span class="syn-cyan">zeros</span>(<span class="syn-yellow">1</span>)
        <span class="syn-fg">realized_vol</span> = <span class="syn-green">float</span>(<span class="syn-fg">np</span>.<span class="syn-cyan">std</span>(<span class="syn-fg">returns</span>) * <span class="syn-fg">np</span>.<span class="syn-cyan">sqrt</span>(<span class="syn-yellow">365</span> * <span class="syn-yellow">24</span> * <span class="syn-yellow">3600</span>))

        <span class="syn-purple">return</span> {
            <span class="syn-orange">"symbol"</span>: <span class="syn-tangerine">snapshot</span>.<span class="syn-pink">symbol</span>,
            <span class="syn-orange">"realized_volatility"</span>: <span class="syn-fg">realized_vol</span>,
            <span class="syn-orange">"spread_bps"</span>: <span class="syn-tangerine">snapshot</span>.<span class="syn-cyan">compute_spread</span>(),
            <span class="syn-orange">"confidence"</span>: <span class="syn-yellow">0.985</span>,
        }`
  },

  rust: {
    filename: 'engine.rs',
    path: 'samples/engine.rs',
    lang: 'Rust',
    code: `<span class="syn-purple">use</span> <span class="syn-green">std::sync::Arc</span>;
<span class="syn-purple">use</span> <span class="syn-green">tokio::sync</span>::{<span class="syn-green">mpsc</span>, <span class="syn-green">RwLock</span>};
<span class="syn-purple">use</span> <span class="syn-green">std::time</span>::{<span class="syn-green">Duration</span>, <span class="syn-green">Instant</span>};

<span class="syn-purple">#[derive(Debug, Clone)]</span>
<span class="syn-pink">pub struct</span> <span class="syn-green syn-italic">VialSignal</span> {
    <span class="syn-purple">pub</span> <span class="syn-pink">market_id</span>: <span class="syn-green">String</span>,
    <span class="syn-purple">pub</span> <span class="syn-pink">price</span>: <span class="syn-green">f64</span>,
    <span class="syn-purple">pub</span> <span class="syn-pink">quantity</span>: <span class="syn-green">f64</span>,
    <span class="syn-purple">pub</span> <span class="syn-pink">direction</span>: <span class="syn-green">TradeDirection</span>,
    <span class="syn-purple">pub</span> <span class="syn-pink">created_at</span>: <span class="syn-green">Instant</span>,
}

<span class="syn-purple">#[derive(Debug, Clone, Copy, PartialEq, Eq)]</span>
<span class="syn-pink">pub enum</span> <span class="syn-green syn-italic">TradeDirection</span> {
    <span class="syn-green">Buy</span>,
    <span class="syn-green">Sell</span>,
}

<span class="syn-pink">pub struct</span> <span class="syn-green syn-italic">VialEngine</span> {
    <span class="syn-pink">signal_rx</span>: <span class="syn-green">mpsc::Receiver</span>&lt;<span class="syn-green">VialSignal</span>&gt;,
    <span class="syn-pink">active_orders</span>: <span class="syn-green">Arc</span>&lt;<span class="syn-green">RwLock</span>&lt;<span class="syn-green">Vec</span>&lt;<span class="syn-green">VialSignal</span>&gt;&gt;&gt;,
    <span class="syn-pink">is_active</span>: <span class="syn-green">bool</span>,
}

<span class="syn-purple">impl</span> <span class="syn-green">VialEngine</span> {
    <span class="syn-purple">pub fn</span> <span class="syn-cyan">new</span>(<span class="syn-tangerine">signal_rx</span>: <span class="syn-green">mpsc::Receiver</span>&lt;<span class="syn-green">VialSignal</span>&gt;) -> <span class="syn-green">Self</span> {
        <span class="syn-green">Self</span> {
            <span class="syn-fg">signal_rx</span>,
            <span class="syn-fg">active_orders</span>: <span class="syn-green">Arc</span>::<span class="syn-cyan">new</span>(<span class="syn-green">RwLock</span>::<span class="syn-cyan">new</span>(<span class="syn-green">Vec</span>::<span class="syn-cyan">with_capacity</span>(<span class="syn-yellow">1024</span>))),
            <span class="syn-fg">is_active</span>: <span class="syn-yellow">true</span>,
        }
    }

    <span class="syn-purple">pub async fn</span> <span class="syn-cyan">run_loop</span>(&<span class="syn-purple">mut</span> <span class="syn-tangerine">self</span>) -> <span class="syn-green">Result</span>&lt;(), <span class="syn-green">Box</span>&lt;<span class="syn-purple">dyn</span> <span class="syn-green">std::error::Error</span>&gt;&gt; {
        <span class="syn-green">println!</span>(<span class="syn-orange">"[Dracula's Vial] Starting high-frequency routing loop..."</span>);

        <span class="syn-purple">while let</span> <span class="syn-green">Some</span>(<span class="syn-fg">signal</span>) = <span class="syn-tangerine">self</span>.<span class="syn-pink">signal_rx</span>.<span class="syn-cyan">recv</span>().<span class="syn-purple">await</span> {
            <span class="syn-purple">if</span> !<span class="syn-tangerine">self</span>.<span class="syn-pink">is_active</span> {
                <span class="syn-purple">break</span>;
            }

            <span class="syn-purple">let</span> <span class="syn-fg">start</span> = <span class="syn-green">Instant</span>::<span class="syn-cyan">now</span>();
            <span class="syn-purple">let mut</span> <span class="syn-fg">orders</span> = <span class="syn-tangerine">self</span>.<span class="syn-pink">active_orders</span>.<span class="syn-cyan">write</span>().<span class="syn-purple">await</span>;
            <span class="syn-fg">orders</span>.<span class="syn-cyan">push</span>(<span class="syn-fg">signal</span>.<span class="syn-cyan">clone</span>());
        }

        <span class="syn-green">Ok</span>(())
    }
}`
  },

  json: {
    filename: 'package.json',
    path: 'package.json',
    lang: 'JSON',
    code: `{
  <span class="syn-cyan">"name"</span>: <span class="syn-orange">"dracula-vial"</span>,
  <span class="syn-cyan">"displayName"</span>: <span class="syn-orange">"Dracula's Vial"</span>,
  <span class="syn-cyan">"description"</span>: <span class="syn-orange">"7 chromatic elixir theme editions anchored by Cyan & Purple."</span>,
  <span class="syn-cyan">"version"</span>: <span class="syn-orange">"1.0.0"</span>,
  <span class="syn-cyan">"author"</span>: <span class="syn-orange">"sevnth"</span>,
  <span class="syn-cyan">"repository"</span>: {
    <span class="syn-cyan">"type"</span>: <span class="syn-orange">"git"</span>,
    <span class="syn-cyan">"url"</span>: <span class="syn-orange">"https://github.com/sevnth/draculas-vial.git"</span>
  },
  <span class="syn-cyan">"engines"</span>: {
    <span class="syn-cyan">"vscode"</span>: <span class="syn-orange">"^1.60.0"</span>
  }
}`
  }
};

// State
let currentColors = { ...PRESETS['dracula-chromatic'].colors };
let currentPresetKey = 'dracula-chromatic';
let currentLang = 'go';

// DOM Elements
const colorPickersContainer = document.getElementById('colorPickersContainer');
const presetSelector = document.getElementById('presetSelector');
const langSelector = document.getElementById('langSelector');
const codeView = document.getElementById('codeView');
const lineNumbers = document.getElementById('lineNumbers');
const minimapLines = document.getElementById('minimapLines');
const activeFilePathTitle = document.getElementById('activeFilePathTitle');
const activeBreadcrumb = document.getElementById('activeBreadcrumb');
const statusLang = document.getElementById('statusLang');
const statusTheme = document.getElementById('statusTheme');
const livePresetBadge = document.getElementById('livePresetBadge');
const btnShareScheme = document.getElementById('btnShareScheme');
const btnExportSettings = document.getElementById('btnExportSettings');
const btnToggleInstall = document.getElementById('btnToggleInstall');
const btnResetPalette = document.getElementById('btnResetPalette');
const modalBackdrop = document.getElementById('modalBackdrop');
const modalTitle = document.getElementById('modalTitle');
const modalBody = document.getElementById('modalBody');
const btnCloseModal = document.getElementById('btnCloseModal');
const toast = document.getElementById('toast');

function showToast(msg = 'Copied!') {
  toast.textContent = msg;
  toast.classList.remove('hidden');
  setTimeout(() => toast.classList.add('hidden'), 2200);
}

// Apply Colors to CSS Variables in Document Root
function applyColorsToRoot() {
  const root = document.documentElement;
  COLOR_CONFIG.forEach(item => {
    const val = currentColors[item.id] || item.defaultHex;
    root.style.setProperty(item.varName, val);
  });
}

// Build Color Picker List in Sidebar
function buildColorPickers() {
  colorPickersContainer.innerHTML = '';
  COLOR_CONFIG.forEach(item => {
    const hex = currentColors[item.id] || item.defaultHex;
    const row = document.createElement('div');
    row.className = 'color-row';
    row.innerHTML = `
      <div class="color-label-group">
        <span class="color-name">${item.label}</span>
        <span class="color-role">${item.role}</span>
      </div>
      <div class="color-input-controls">
        <div class="color-input-wrapper" style="background: ${hex};" id="wrapper-${item.id}">
          <input type="color" class="color-native-input" id="native-${item.id}" value="${hex}">
        </div>
        <input type="text" class="hex-text-input" id="text-${item.id}" value="${hex}" maxlength="7" spellcheck="false">
      </div>
    `;

    colorPickersContainer.appendChild(row);

    const nativeInput = row.querySelector(`#native-${item.id}`);
    const textInput = row.querySelector(`#text-${item.id}`);
    const wrapper = row.querySelector(`#wrapper-${item.id}`);

    nativeInput.addEventListener('input', (e) => {
      const val = e.target.value;
      currentColors[item.id] = val;
      textInput.value = val;
      wrapper.style.background = val;
      applyColorsToRoot();
      markCustomPreset();
    });

    textInput.addEventListener('change', (e) => {
      let val = e.target.value.trim();
      if (!val.startsWith('#')) val = '#' + val;
      if (/^#[0-9A-Fa-f]{6}$/.test(val)) {
        currentColors[item.id] = val;
        nativeInput.value = val;
        wrapper.style.background = val;
        applyColorsToRoot();
        markCustomPreset();
      } else {
        textInput.value = currentColors[item.id];
      }
    });
  });
}

function updateColorPickerInputs() {
  COLOR_CONFIG.forEach(item => {
    const hex = currentColors[item.id];
    const nativeInput = document.getElementById(`native-${item.id}`);
    const textInput = document.getElementById(`text-${item.id}`);
    const wrapper = document.getElementById(`wrapper-${item.id}`);
    if (nativeInput) nativeInput.value = hex;
    if (textInput) textInput.value = hex;
    if (wrapper) wrapper.style.background = hex;
  });
}

function markCustomPreset() {
  currentPresetKey = 'custom';
  presetSelector.value = 'custom';
  livePresetBadge.textContent = 'Custom Live';
  document.querySelectorAll('.preset-btn').forEach(btn => btn.classList.remove('active'));
}

function loadPreset(presetKey) {
  const preset = PRESETS[presetKey];
  if (!preset) return;

  currentPresetKey = presetKey;
  currentColors = { ...preset.colors };
  presetSelector.value = presetKey;
  livePresetBadge.textContent = preset.badge;

  // Update preset buttons active state
  document.querySelectorAll('.preset-btn').forEach(btn => {
    if (btn.getAttribute('data-preset') === presetKey) {
      btn.classList.add('active');
    } else {
      btn.classList.remove('active');
    }
  });

  applyColorsToRoot();
  updateColorPickerInputs();
}

function renderCode(langKey) {
  const sample = CODE_SAMPLES[langKey] || CODE_SAMPLES.go;
  currentLang = langKey;

  activeFilePathTitle.textContent = sample.path;
  activeBreadcrumb.textContent = sample.filename;
  statusLang.textContent = sample.lang;
  if (langSelector.value !== langKey) {
    langSelector.value = langKey;
  }

  document.querySelectorAll('.tabs-bar .tab').forEach(tab => {
    if (tab.getAttribute('data-lang') === langKey) tab.classList.add('active');
    else tab.classList.remove('active');
  });

  document.querySelectorAll('.file-tree .file').forEach(file => {
    if (file.getAttribute('data-lang') === langKey) file.classList.add('active');
    else file.classList.remove('active');
  });

  codeView.querySelector('code').innerHTML = sample.code;

  // Lines & Minimap
  const lines = sample.code.split('\n');
  let lineNumbersHtml = '';
  let minimapHtml = '';

  lines.forEach((line, index) => {
    const lineNum = index + 1;
    const isActive = lineNum === 18 ? 'active-line' : '';
    lineNumbersHtml += `<span class="${isActive}">${lineNum}</span><br>`;

    let color = 'rgba(104, 117, 158, 0.3)';
    let width = Math.min(100, Math.max(20, line.length * 1.5)) + '%';
    if (line.includes('syn-purple')) color = 'var(--drac-purple)';
    else if (line.includes('syn-cyan')) color = 'var(--drac-cyan)';
    else if (line.includes('syn-orange')) color = 'var(--drac-orange)';
    else if (line.includes('syn-green')) color = 'var(--drac-green)';
    else if (line.includes('syn-yellow')) color = 'var(--drac-yellow)';
    else if (line.includes('syn-pink')) color = 'var(--drac-pink)';
    else if (line.includes('syn-tangerine')) color = 'var(--drac-tangerine)';

    minimapHtml += `<div class="minimap-line" style="background: ${color}; width: ${width};"></div>`;
  });

  lineNumbers.innerHTML = lineNumbersHtml;
  minimapLines.innerHTML = minimapHtml;
}

// Preset Selector
presetSelector.addEventListener('change', (e) => {
  if (e.target.value !== 'custom') {
    loadPreset(e.target.value);
  }
});

// Preset Buttons Grid
document.querySelectorAll('.preset-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    const p = btn.getAttribute('data-preset');
    if (p) loadPreset(p);
  });
});

// Reset Button
btnResetPalette.addEventListener('click', () => {
  const targetPreset = currentPresetKey !== 'custom' ? currentPresetKey : 'dracula-chromatic';
  loadPreset(targetPreset);
  showToast('Reset palette to preset defaults!');
});

// Language switcher
langSelector.addEventListener('change', (e) => {
  renderCode(e.target.value);
});

// Tab click
document.querySelectorAll('.tabs-bar .tab').forEach(tab => {
  tab.addEventListener('click', () => {
    const l = tab.getAttribute('data-lang');
    if (l) renderCode(l);
  });
});

// Sidebar file click
document.querySelectorAll('.file-tree .file').forEach(node => {
  node.addEventListener('click', () => {
    const l = node.getAttribute('data-lang');
    if (l) renderCode(l);
  });
});

// "Suggest Color Scheme" Modal
btnShareScheme.addEventListener('click', () => {
  modalTitle.textContent = "Suggest Your Custom Dracula's Vial Scheme";

  const snippet = `### My Custom Dracula's Vial Color Scheme:
- **Keywords / Control Flow:** \`${currentColors.purple}\`
- **Functions & Methods:** \`${currentColors.cyan}\`
- **Strings & Text:** \`${currentColors.orange}\`
- **Types & Structs:** \`${currentColors.green}\`
- **Numbers & Booleans:** \`${currentColors.yellow}\`
- **Struct Fields & Properties:** \`${currentColors.pink}\`
- **Parameters & Tags:** \`${currentColors.tangerine}\`
- **Comments & Docstrings:** \`${currentColors.comment}\`
- **Editor Background:** \`${currentColors.bg}\`
- **Sidebar & Panels:** \`${currentColors.bgDarker}\``;

  modalBody.innerHTML = `
    <p style="margin-bottom: 12px; color: var(--drac-fg);">
      You can copy this color palette block and paste it directly into our chat conversation so I can create a dedicated theme file for it:
    </p>
    <pre class="modal-code-block"><code>${snippet.replace(/</g, '&lt;')}</code></pre>
    <button class="btn btn-accent" id="btnCopySuggestedScheme" style="margin-top: 8px;">
      Copy Scheme to Paste in Chat
    </button>
  `;

  modalBackdrop.classList.remove('hidden');

  document.getElementById('btnCopySuggestedScheme').addEventListener('click', () => {
    navigator.clipboard.writeText(snippet).then(() => {
      showToast('Copied scheme block! Paste it in chat.');
      modalBackdrop.classList.add('hidden');
    });
  });
});

// Export Settings Modal
btnExportSettings.addEventListener('click', () => {
  modalTitle.textContent = "VS Code settings.json (Dracula's Vial)";

  const settingsJson = `{
  "workbench.colorTheme": "${PRESETS[currentPresetKey]?.name || "Dracula's Vial"}",
  "editor.tokenColorCustomizations": {
    "[*]": {
      "keywords": "${currentColors.purple}",
      "functions": "${currentColors.cyan}",
      "types": "${currentColors.green}",
      "strings": "${currentColors.orange}",
      "numbers": "${currentColors.yellow}",
      "constants": "${currentColors.yellow}",
      "comments": "${currentColors.comment}",
      "variables": "#f8f8f2"
    }
  },
  "workbench.colorCustomizations": {
    "[*]": {
      "editor.background": "${currentColors.bg}",
      "sideBar.background": "${currentColors.bgDarker}",
      "activityBar.background": "${currentColors.bgDarker}",
      "activityBar.activeBorder": "${currentColors.purple}",
      "activityBarBadge.background": "${currentColors.purple}",
      "editorCursor.foreground": "${currentColors.cyan}",
      "tab.activeBorderTop": "${currentColors.cyan}",
      "editorLineNumber.activeForeground": "${currentColors.cyan}"
    }
  }
}`;

  modalBody.innerHTML = `
    <p style="margin-bottom: 12px; color: var(--drac-fg);">
      Copy and paste this configuration directly into your user or workspace <code>settings.json</code> to apply your live customized colors:
    </p>
    <pre class="modal-code-block"><code>${settingsJson.replace(/</g, '&lt;')}</code></pre>
    <button class="btn btn-primary" id="btnCopySettingsJson" style="margin-top: 8px;">
      Copy settings.json Block
    </button>
  `;

  modalBackdrop.classList.remove('hidden');

  document.getElementById('btnCopySettingsJson').addEventListener('click', () => {
    navigator.clipboard.writeText(settingsJson).then(() => {
      showToast('Copied settings.json configuration!');
      modalBackdrop.classList.add('hidden');
    });
  });
});

// Install Modal
btnToggleInstall.addEventListener('click', () => {
  modalTitle.textContent = "Installation & Setup — Dracula's Vial";
  modalBody.innerHTML = `
    <div style="display: flex; flex-direction: column; gap: 16px;">
      <div>
        <h4 style="color: var(--drac-cyan); margin-bottom: 6px;">Option 1: Local Folder Copy</h4>
        <pre class="modal-code-block"><code># Windows PowerShell
Copy-Item -Recurse "C:\\Users\\sevnth\\draculas-vial" "$HOME\\.vscode\\extensions\\draculas-vial"</code></pre>
      </div>

      <div>
        <h4 style="color: var(--drac-purple); margin-bottom: 6px;">Option 2: Theme Selection</h4>
        <p style="color: var(--drac-comment); font-size: 0.85rem;">
          Press <kbd style="background: #282a36; padding: 2px 6px; border-radius: 4px; border: 1px solid #44475a;">Ctrl + K</kbd> then <kbd style="background: #282a36; padding: 2px 6px; border-radius: 4px; border: 1px solid #44475a;">Ctrl + T</kbd> to explore all 7 Dracula's Vial editions!
        </p>
      </div>
    </div>
  `;
  modalBackdrop.classList.remove('hidden');
});

btnCloseModal.addEventListener('click', () => modalBackdrop.classList.add('hidden'));
modalBackdrop.addEventListener('click', (e) => {
  if (e.target === modalBackdrop) modalBackdrop.classList.add('hidden');
});

// Initial Setup
buildColorPickers();
applyColorsToRoot();
renderCode('go');
