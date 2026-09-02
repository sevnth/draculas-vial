use std::sync::Arc;
use tokio::sync::{mpsc, RwLock};
use std::time::{Duration, Instant};

#[derive(Debug, Clone)]
pub struct TradeSignal {
    pub market_id: String,
    pub price: f64,
    pub quantity: f64,
    pub direction: TradeDirection,
    pub created_at: Instant,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum TradeDirection {
    Buy,
    Sell,
}

pub struct ExecutionEngine {
    signal_rx: mpsc::Receiver<TradeSignal>,
    active_orders: Arc<RwLock<Vec<TradeSignal>>>,
    is_active: bool,
}

impl ExecutionEngine {
    pub fn new(signal_rx: mpsc::Receiver<TradeSignal>) -> Self {
        Self {
            signal_rx,
            active_orders: Arc::new(RwLock::new(Vec::with_capacity(1024))),
            is_active: true,
        }
    }

    pub async fn run_loop(&mut self) -> Result<(), Box<dyn std::error::Error>> {
        println!("[Engine] Starting high-frequency routing loop...");

        while let Some(signal) = self.signal_rx.recv().await {
            if !self.is_active {
                break;
            }

            let start = Instant::now();
            let mut orders = self.active_orders.write().await;
            orders.push(signal.clone());

            let elapsed = start.elapsed();
            println!(
                "[Trade] Processed {:?} for {} @ {:.2} in {:?}",
                signal.direction, signal.market_id, signal.price, elapsed
            );
        }

        Ok(())
    }
}
