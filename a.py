        return rl_cluster_lib.RLCluster(
            actor: ModelOrPath,
            critic: ModelOrPath | None = None,
            reference: ModelOrPath | None = None,
            reward: ModelOrPath | None = None,
            tokenizer: Any | None,
            cluster_config: ClusterConfig,
            perf_config: perf_metrics.PerfMetricsConfig | None = None,

