import React, { useState, useEffect, useMemo, useCallback } from 'react';

interface MetricRecord {
  id: string;
  timestamp: number;
  label: string;
  value: number;
  status: 'healthy' | 'warning' | 'critical';
  tags: string[];
}

interface DashboardProps {
  title: string;
  refreshIntervalMs?: number;
  onAlertTriggered?: (alertId: string, level: string) => void;
}

export const MetricsDashboard: React.FC<DashboardProps> = ({
  title,
  refreshIntervalMs = 3000,
  onAlertTriggered,
}) => {
  const [metrics, setMetrics] = useState<MetricRecord[]>([]);
  const [filterTag, setFilterTag] = useState<string>('all');
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // Fetch telemetry from WebSocket endpoint
  const fetchTelemetry = useCallback(async () => {
    try {
      setIsLoading(true);
      const response = await fetch('/api/v1/telemetry/live');
      const data: MetricRecord[] = await response.json();
      setMetrics(data);
    } catch (error) {
      console.error('Failed to stream metrics:', error);
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchTelemetry();
    const interval = setInterval(fetchTelemetry, refreshIntervalMs);
    return () => clearInterval(interval);
  }, [fetchTelemetry, refreshIntervalMs]);

  const activeAlertCount = useMemo(() => {
    return metrics.filter((m) => m.status === 'critical').length;
  }, [metrics]);

  return (
    <div className="dashboard-container" data-testid="telemetry-root">
      <header className="dashboard-header flex items-center justify-between">
        <h1 className="text-xl font-bold tracking-tight text-cyan-400">{title}</h1>
        <div className="badge-group flex gap-2">
          <span className="badge badge-purple">Live Nodes: {metrics.length}</span>
          {activeAlertCount > 0 && (
            <span className="badge badge-orange">Alerts: {activeAlertCount}</span>
          )}
        </div>
      </header>
      <main className="grid grid-cols-3 gap-4 mt-6">
        {metrics.map((item) => (
          <article key={item.id} className="metric-card p-4 rounded-xl">
            <h3 className="font-semibold text-white">{item.label}</h3>
            <p className="text-2xl font-mono text-amber-300">{item.value.toFixed(2)} ms</p>
          </article>
        ))}
      </main>
    </div>
  );
};
