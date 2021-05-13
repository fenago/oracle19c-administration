REM For training only
set echo on
-- Remove hidden parameters for 12c
--alter system set "_PX_use_large_pool" = TRUE SCOPE=SPFILE;
--alter system set "_memory_broker_stat_interval" = 5 SCOPE=SPFILE;
--alter system set "_memory_management_tracing" = 31 SCOPE=SPFILE;
alter system set "parallel_execution_message_size" = 36864 SCOPE=SPFILE;
alter system set "parallel_max_servers" = 200 SCOPE=SPFILE;
alter system set "parallel_adaptive_multi_user" = FALSE SCOPE=SPFILE;
alter system set "processes" = 200 SCOPE=SPFILE;
alter system set "pga_aggregate_target" = 0 SCOPE=SPFILE;
alter system set "sga_target" = 0 SCOPE=SPFILE;
alter system set "memory_target" = 624M SCOPE=SPFILE;
