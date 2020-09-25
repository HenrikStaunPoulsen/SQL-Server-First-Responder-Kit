exec ('create schema mastersys')
exec ('create schema modelsys')
exec ('create schema msdbsys')
exec ('create schema msdbdbo')
exec ('create schema msdbinformation_schema')
exec ('create schema masterINFORMATION_SCHEMA')
exec ('create schema masterdbo')


/*
go
create DATABASE SCOPED CREDENTIAL myCred
WITH IDENTITY = 'mySQLuser', SECRET = 'mypassword';
go
CREATE EXTERNAL DATA SOURCE Master
WITH
(
    TYPE = RDBMS,
    LOCATION = N'myServer.database.windows.net',
    DATABASE_NAME = N'master',
    CREDENTIAL = myCred
);
--*/
go

create or alter view mastersys.dm_exec_sessions
/* 
test harness:
select top (10000) * from mastersys.dm_exec_sessions 
*/
as 
    select des.session_id, des.login_time, des.host_name, des.program_name, des.host_process_id, des.client_version, des.client_interface_name, des.security_id, des.login_name, des.nt_domain, des.nt_user_name, des.status, des.context_info, des.cpu_time, des.memory_usage, des.total_scheduled_time
         , des.total_elapsed_time, des.endpoint_id, des.last_request_start_time, des.last_request_end_time, des.reads, des.writes, des.logical_reads, des.is_user_process, des.text_size, des.language, des.date_format, des.date_first, des.quoted_identifier, des.arithabort, des.ansi_null_dflt_on
         , des.ansi_defaults, des.ansi_warnings, des.ansi_padding, des.ansi_nulls, des.concat_null_yields_null, des.transaction_isolation_level, des.lock_timeout, des.deadlock_priority, des.row_count, des.prev_error, des.original_security_id, des.original_login_name, des.last_successful_logon
         , des.last_unsuccessful_logon, des.unsuccessful_logons, des.group_id, des.database_id, des.authenticating_database_id, des.open_transaction_count, des.is_filtered, des.page_server_reads 
    from sys.dm_exec_sessions des
go

create or alter view mastersys.dm_exec_connections
/* 
test harness:
select top (10000) * from mastersys.dm_exec_connections 
*/
as 
    select des.session_id, des.most_recent_session_id, des.connect_time, des.net_transport, des.protocol_type, des.protocol_version, des.endpoint_id, des.encrypt_option, des.auth_scheme, des.node_affinity, des.num_reads, des.num_writes, des.last_read, des.last_write, des.net_packet_size
         , des.client_net_address, des.client_tcp_port, des.local_net_address, des.local_tcp_port, des.connection_id, des.parent_connection_id, des.most_recent_sql_handle
    from sys.dm_exec_connections des
go


CREATE external TABLE mastersys.all_objects ( [name] nvarchar(128), [object_id] int, [principal_id] int, [schema_id] int, [parent_object_id] int, [type] char(2), [type_desc] nvarchar(60), [create_date] datetime, [modify_date] datetime, [is_ms_shipped] bit, [is_published] bit, [is_schema_published] bit )
/* 
test harness:
select top (10000) * from mastersys.all_objects 
*/
WITH
( DATA_SOURCE = Master,
SCHEMA_NAME = 'sys',
OBJECT_NAME = 'all_objects');
go
CREATE external TABLE mastersys.tables ( [name] nvarchar(128), [object_id] int, [principal_id] int, [schema_id] int, [parent_object_id] int, [type] char(2), [type_desc] nvarchar(60), [create_date] datetime, [modify_date] datetime, [is_ms_shipped] bit, [is_published] bit, [is_schema_published] bit, [lob_data_space_id] int, [filestream_data_space_id] int, [max_column_id_used] int, [lock_on_bulk_load] bit, [uses_ansi_nulls] bit, [is_replicated] bit, [has_replication_filter] bit, [is_merge_published] bit, [is_sync_tran_subscribed] bit, [has_unchecked_assembly_data] bit, [text_in_row_limit] int, [large_value_types_out_of_row] bit, [is_tracked_by_cdc] bit, [lock_escalation] tinyint, [lock_escalation_desc] nvarchar(60), [is_filetable] bit, [is_memory_optimized] bit, [durability] tinyint, [durability_desc] nvarchar(60), [temporal_type] tinyint, [temporal_type_desc] nvarchar(60), [history_table_id] int, [is_remote_data_archive_enabled] bit, [is_external] bit, [history_retention_period] int, [history_retention_period_unit] int, [history_retention_period_unit_desc] nvarchar(10), [is_node] bit, [is_edge] bit )
/* 
test harness:
select top (10000) * from mastersys.tables 
*/
WITH
( DATA_SOURCE = Master,
SCHEMA_NAME = 'sys',
OBJECT_NAME = 'tables');
go
CREATE external TABLE msdbsys.all_objects ( [name] nvarchar(128), [object_id] int, [principal_id] int, [schema_id] int, [parent_object_id] int, [type] char(2), [type_desc] nvarchar(60), [create_date] datetime, [modify_date] datetime, [is_ms_shipped] bit, [is_published] bit, [is_schema_published] bit )
/* 
test harness:
select top (10000) * from msdbsys.all_objects
*/
WITH
( DATA_SOURCE = Master,
SCHEMA_NAME = 'sys',
OBJECT_NAME = 'all_objects');
go
CREATE external TABLE msdbsys.tables ( [name] nvarchar(128), [object_id] int, [principal_id] int, [schema_id] int, [parent_object_id] int, [type] char(2), [type_desc] nvarchar(60), [create_date] datetime, [modify_date] datetime, [is_ms_shipped] bit, [is_published] bit, [is_schema_published] bit, [lob_data_space_id] int, [filestream_data_space_id] int, [max_column_id_used] int, [lock_on_bulk_load] bit, [uses_ansi_nulls] bit, [is_replicated] bit, [has_replication_filter] bit, [is_merge_published] bit, [is_sync_tran_subscribed] bit, [has_unchecked_assembly_data] bit, [text_in_row_limit] int, [large_value_types_out_of_row] bit, [is_tracked_by_cdc] bit, [lock_escalation] tinyint, [lock_escalation_desc] nvarchar(60), [is_filetable] bit, [is_memory_optimized] bit, [durability] tinyint, [durability_desc] nvarchar(60), [temporal_type] tinyint, [temporal_type_desc] nvarchar(60), [history_table_id] int, [is_remote_data_archive_enabled] bit, [is_external] bit, [history_retention_period] int, [history_retention_period_unit] int, [history_retention_period_unit_desc] nvarchar(10), [is_node] bit, [is_edge] bit )
/* 
test harness:
select top (10000) * from msdbsys.tables
*/
WITH
( DATA_SOURCE = master,
SCHEMA_NAME = 'sys',
OBJECT_NAME = 'tables');
go
CREATE external TABLE modelsys.tables ( [name] nvarchar(128), [object_id] int, [principal_id] int, [schema_id] int, [parent_object_id] int, [type] char(2), [type_desc] nvarchar(60), [create_date] datetime, [modify_date] datetime, [is_ms_shipped] bit, [is_published] bit, [is_schema_published] bit, [lob_data_space_id] int, [filestream_data_space_id] int, [max_column_id_used] int, [lock_on_bulk_load] bit, [uses_ansi_nulls] bit, [is_replicated] bit, [has_replication_filter] bit, [is_merge_published] bit, [is_sync_tran_subscribed] bit, [has_unchecked_assembly_data] bit, [text_in_row_limit] int, [large_value_types_out_of_row] bit, [is_tracked_by_cdc] bit, [lock_escalation] tinyint, [lock_escalation_desc] nvarchar(60), [is_filetable] bit, [is_memory_optimized] bit, [durability] tinyint, [durability_desc] nvarchar(60), [temporal_type] tinyint, [temporal_type_desc] nvarchar(60), [history_table_id] int, [is_remote_data_archive_enabled] bit, [is_external] bit, [history_retention_period] int, [history_retention_period_unit] int, [history_retention_period_unit_desc] nvarchar(10), [is_node] bit, [is_edge] bit )
/* 
test harness:
select top (10000) * from modelsys.tables
*/
WITH
( DATA_SOURCE = master,
SCHEMA_NAME = 'sys',
OBJECT_NAME = 'tables');
go

CREATE or alter view msdbdbo.sysalerts 
/* 
test harness:
select top (10000) * from msdbdbo.sysalerts
*/
as
    select 
    19 as severity
    , 1 as enabled
    , 0 as has_notification
    , null as job_id
    , 823 as Message_Id
    , 'test' as name
    , 0 as include_event_description
    --from dbo.GetNums(7) gn
    from (
        values
        ( 1 ), 
        ( 2 ), 
        ( 3 ), 
        ( 4 ), 
        ( 5 ), 
        ( 6 ), 
        ( 7 )
    ) a(i)
--
go
CREATE or alter view msdbdbo.sysjobs 
/* 
test harness:
select top (10000) * from msdbdbo.sysjobs
*/
as
    select 
    19 as owner_sid
    , 1 as enabled
    , 'test' as name
	, cast(0 as int) as job_id
	, cast(0 as int) as notify_email_operator_id
	, cast(0 as int) as notify_netsend_operator_id
	, cast(0 as int) as notify_page_operator_id
	, cast(0 as int) as category_id
    where 1=2
go

create or alter view msdbINFORMATION_SCHEMA.columns
/* 
test harness:
select top (10000) * from msdbINFORMATION_SCHEMA.columns
*/
as  
    select c.TABLE_CATALOG, c.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.ORDINAL_POSITION, c.COLUMN_DEFAULT, c.IS_NULLABLE, c.DATA_TYPE, c.CHARACTER_MAXIMUM_LENGTH, c.CHARACTER_OCTET_LENGTH, c.NUMERIC_PRECISION, c.NUMERIC_PRECISION_RADIX, c.NUMERIC_SCALE, c.DATETIME_PRECISION, c.CHARACTER_SET_CATALOG
         , c.CHARACTER_SET_SCHEMA, c.CHARACTER_SET_NAME, c.COLLATION_CATALOG, c.COLLATION_SCHEMA, c.COLLATION_NAME, c.DOMAIN_CATALOG, c.DOMAIN_SCHEMA, c.DOMAIN_NAME 
    from INFORMATION_SCHEMA.COLUMNS c
go

create or alter view masterINFORMATION_SCHEMA.columns
/* 
test harness:
select top (10000) * from masterINFORMATION_SCHEMA.columns
*/
as  
    select c.TABLE_CATALOG, c.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.ORDINAL_POSITION, c.COLUMN_DEFAULT, c.IS_NULLABLE, c.DATA_TYPE, c.CHARACTER_MAXIMUM_LENGTH, c.CHARACTER_OCTET_LENGTH, c.NUMERIC_PRECISION, c.NUMERIC_PRECISION_RADIX, c.NUMERIC_SCALE, c.DATETIME_PRECISION, c.CHARACTER_SET_CATALOG
         , c.CHARACTER_SET_SCHEMA, c.CHARACTER_SET_NAME, c.COLLATION_CATALOG, c.COLLATION_SCHEMA, c.COLLATION_NAME, c.DOMAIN_CATALOG, c.DOMAIN_SCHEMA, c.DOMAIN_NAME 
    from INFORMATION_SCHEMA.COLUMNS c
go

create EXTERNAL TABLE masterINFORMATION_SCHEMA.ROUTINES
/* 
test harness:
select top (10000) * from masterINFORMATION_SCHEMA.ROUTINES
*/
( [SPECIFIC_CATALOG] nvarchar(128), [SPECIFIC_SCHEMA] nvarchar(128), [SPECIFIC_NAME] nvarchar(128), [ROUTINE_CATALOG] nvarchar(128), [ROUTINE_SCHEMA] nvarchar(128), [ROUTINE_NAME] nvarchar(128), [ROUTINE_TYPE] nvarchar(20), [MODULE_CATALOG] nvarchar(128), [MODULE_SCHEMA] nvarchar(128), [MODULE_NAME] nvarchar(128), [UDT_CATALOG] nvarchar(128), [UDT_SCHEMA] nvarchar(128), [UDT_NAME] nvarchar(128), [DATA_TYPE] nvarchar(128), [CHARACTER_MAXIMUM_LENGTH] int, [CHARACTER_OCTET_LENGTH] int, [COLLATION_CATALOG] nvarchar(128), [COLLATION_SCHEMA] nvarchar(128), [COLLATION_NAME] nvarchar(128), [CHARACTER_SET_CATALOG] nvarchar(128), [CHARACTER_SET_SCHEMA] nvarchar(128), [CHARACTER_SET_NAME] nvarchar(128), [NUMERIC_PRECISION] tinyint, [NUMERIC_PRECISION_RADIX] smallint, [NUMERIC_SCALE] int, [DATETIME_PRECISION] smallint, [INTERVAL_TYPE] nvarchar(30), [INTERVAL_PRECISION] smallint, [TYPE_UDT_CATALOG] nvarchar(128), [TYPE_UDT_SCHEMA] nvarchar(128), [TYPE_UDT_NAME] nvarchar(128), [SCOPE_CATALOG] nvarchar(128), [SCOPE_SCHEMA] nvarchar(128), [SCOPE_NAME] nvarchar(128), [MAXIMUM_CARDINALITY] bigint, [DTD_IDENTIFIER] nvarchar(128), [ROUTINE_BODY] nvarchar(30), [ROUTINE_DEFINITION] nvarchar(4000), [EXTERNAL_NAME] nvarchar(128), [EXTERNAL_LANGUAGE] nvarchar(30), [PARAMETER_STYLE] nvarchar(30), [IS_DETERMINISTIC] nvarchar(10), [SQL_DATA_ACCESS] nvarchar(30), [IS_NULL_CALL] nvarchar(10), [SQL_PATH] nvarchar(128), [SCHEMA_LEVEL_ROUTINE] nvarchar(10), [MAX_DYNAMIC_RESULT_SETS] smallint, [IS_USER_DEFINED_CAST] nvarchar(10), [IS_IMPLICITLY_INVOCABLE] nvarchar(10), [CREATED] datetime, [LAST_ALTERED] datetime )    
WITH
( DATA_SOURCE = Master,
SCHEMA_NAME = 'INFORMATION_SCHEMA',
OBJECT_NAME = 'ROUTINES');
go

CREATE EXTERNAL TABLE mastersys.sql_logins
/* 
test harness:
select top (10000) * from mastersys.sql_logins
*/
(
    [name] nvarchar(128),
    principal_id int,
    sid varbinary(85),
    type char(1),
    type_desc nvarchar(60),
    is_disabled bit /*int*/,
    create_Date DATETIME,
    modify_date DATETIME,
    default_database_name SYSNAME,
    is_policy_checked bit,
    is_expiration_checked bit,
    password_hash varbinary(512 /* was 256 */)
) WITH
( DATA_SOURCE = Master,
SCHEMA_NAME = 'sys',
OBJECT_NAME = 'sql_logins');
go

CREATE EXTERNAL TABLE mastersys.event_log
/* 
test harness:
select top (10000) * from mastersys.event_log
*/
( database_name nvarchar(128), start_time datetime2(7), end_time datetime2(7), event_category nvarchar(64), event_type nvarchar(64), event_subtype int, event_subtype_desc nvarchar(64), severity int, event_count int, description nvarchar(64)  /*, additional_data xml */ )
WITH
( DATA_SOURCE = Master,
SCHEMA_NAME = 'sys',
OBJECT_NAME = 'event_log');

--select top (10000) database_name, start_time, end_time, event_category, event_type, event_subtype, event_subtype_desc, severity, event_count, description /*, additional_data*/ from mastersys.event_log
go
create external table mastersys.databases_raw
/*
test harness:
select top (10000) * from mastersys.databases_raw d
*/
(
[name] SYSNAME,
[database_id] INT NOT NULL,
[source_database_id] INT,
[owner_sid] VARBINARY(85),
[create_date] DATETIME NOT NULL,
[compatibility_level] TINYINT NOT NULL,
[collation_name] SYSNAME,
[user_access] TINYINT,
[user_access_desc] NVARCHAR(60),
[is_read_only] BIT,
[is_auto_close_on] BIT NOT NULL,
[is_auto_shrink_on] BIT,
[state] TINYINT,
[state_desc] NVARCHAR(60),
[is_in_standby] BIT,
[is_cleanly_shutdown] BIT,
[is_supplemental_logging_enabled] BIT,
[snapshot_isolation_state] TINYINT,
[snapshot_isolation_state_desc] NVARCHAR(60),
[is_read_committed_snapshot_on] BIT,
[recovery_model] TINYINT,
[recovery_model_desc] NVARCHAR(60),
[page_verify_option] TINYINT,
[page_verify_option_desc] NVARCHAR(60),
[is_auto_create_stats_on] BIT,
[is_auto_create_stats_incremental_on] BIT,
[is_auto_update_stats_on] BIT,
[is_auto_update_stats_async_on] BIT,
[is_ansi_null_default_on] BIT,
[is_ansi_nulls_on] BIT,
[is_ansi_padding_on] BIT,
[is_ansi_warnings_on] BIT,
[is_arithabort_on] BIT,
[is_concat_null_yields_null_on] BIT,
[is_numeric_roundabort_on] BIT,
[is_quoted_identifier_on] BIT,
[is_recursive_triggers_on] BIT,
[is_cursor_close_on_commit_on] BIT,
[is_local_cursor_default] BIT,
[is_fulltext_enabled] BIT,
[is_trustworthy_on] BIT,
[is_db_chaining_on] BIT,
[is_parameterization_forced] BIT,
[is_master_key_encrypted_by_server] BIT NOT NULL,
[is_query_store_on] BIT,
[is_published] BIT NOT NULL,
[is_subscribed] BIT NOT NULL,
[is_merge_published] BIT NOT NULL,
[is_distributor] BIT NOT NULL,
[is_sync_with_backup] BIT NOT NULL,
[service_broker_guid] UNIQUEIDENTIFIER NOT NULL,
[is_broker_enabled] BIT NOT NULL,
[log_reuse_wait] TINYINT,
[log_reuse_wait_desc] NVARCHAR(60),
[is_date_correlation_on] BIT NOT NULL,
[is_cdc_enabled] BIT NOT NULL,
[is_encrypted] BIT,
[is_honor_broker_priority_on] BIT,
[replica_id] UNIQUEIDENTIFIER,
[group_database_id] UNIQUEIDENTIFIER,
[resource_pool_id] INT,
[default_language_lcid] SMALLINT,
[default_language_name] NVARCHAR(128),
[default_fulltext_language_lcid] INT,
[default_fulltext_language_name] NVARCHAR(128),
[is_nested_triggers_on] BIT,
[is_transform_noise_words_on] BIT,
[two_digit_year_cutoff] SMALLINT,
[containment] TINYINT,
[containment_desc] NVARCHAR(60),
[target_recovery_time_in_seconds] INT,
[delayed_durability] INT,
[delayed_durability_desc] NVARCHAR(60),
[is_memory_optimized_elevate_to_snapshot_on] BIT,
[is_federation_member] BIT,
[is_remote_data_archive_enabled] BIT,
[is_mixed_page_allocation_on] BIT,
[is_temporal_history_retention_enabled] BIT,
[catalog_collation_type] INT NOT NULL,
[catalog_collation_type_desc] NVARCHAR(60),
[physical_database_name] NVARCHAR(128),
[is_result_set_caching_on] BIT,
[is_accelerated_database_recovery_on] BIT,
[is_tempdb_spill_to_remote_store] BIT,
[is_stale_page_detection_on] BIT,
[is_memory_optimized_enabled] BIT
)
with (DATA_SOURCE  = Master, schema_name = N'sys', object_name = N'databases') 
go
create or alter view mastersys.databases 
/*
test harness:
select top (10000) * from mastersys.databases d
*/
as  
    select name, database_id, source_database_id, owner_sid, create_date, compatibility_level, collation_name, user_access, user_access_desc, is_read_only, is_auto_close_on, is_auto_shrink_on, state, state_desc, is_in_standby, is_cleanly_shutdown, is_supplemental_logging_enabled
         , snapshot_isolation_state, snapshot_isolation_state_desc, is_read_committed_snapshot_on, recovery_model, recovery_model_desc, page_verify_option, page_verify_option_desc, is_auto_create_stats_on, is_auto_create_stats_incremental_on, is_auto_update_stats_on, is_auto_update_stats_async_on
         , is_ansi_null_default_on, is_ansi_nulls_on, is_ansi_padding_on, is_ansi_warnings_on, is_arithabort_on, is_concat_null_yields_null_on, is_numeric_roundabort_on, is_quoted_identifier_on, is_recursive_triggers_on, is_cursor_close_on_commit_on, is_local_cursor_default, is_fulltext_enabled
         , is_trustworthy_on, is_db_chaining_on, is_parameterization_forced, is_master_key_encrypted_by_server, is_query_store_on, is_published, is_subscribed, is_merge_published, is_distributor, is_sync_with_backup, service_broker_guid, is_broker_enabled, log_reuse_wait, log_reuse_wait_desc
         , is_date_correlation_on, is_cdc_enabled, is_encrypted, is_honor_broker_priority_on, replica_id, group_database_id, resource_pool_id, default_language_lcid, default_language_name, default_fulltext_language_lcid, default_fulltext_language_name, is_nested_triggers_on, is_transform_noise_words_on
         , two_digit_year_cutoff, containment, containment_desc, target_recovery_time_in_seconds, delayed_durability, delayed_durability_desc, is_memory_optimized_elevate_to_snapshot_on, is_federation_member, is_remote_data_archive_enabled, is_mixed_page_allocation_on
         , is_temporal_history_retention_enabled, catalog_collation_type, catalog_collation_type_desc, physical_database_name, is_result_set_caching_on, is_accelerated_database_recovery_on, is_tempdb_spill_to_remote_store, is_stale_page_detection_on, is_memory_optimized_enabled
    from mastersys.databases_raw
    union all
    select N'tempdb', 2, NULL, 0x01, min(last_request_start_time) as ServerStartTime, 150, N'SQL_Latin1_General_CP1_CI_AS', 0, N'MULTI_USER', 0, 0, 0, 0, N'ONLINE', 0, 0, 0, 0, N'OFF', 0, 3, N'SIMPLE', 2, N'CHECKSUM', 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '{3a1fdae0-d308-4470-8163-a577e107b5d7}', 1, 0, N'NOTHING', 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'NONE', 60, 0, N'DISABLED', 0, 0, 0, 0, 1, 0, N'DATABASE_DEFAULT', N'tempdb', 0, 0, 0, 0, 1 
    from sys.dm_exec_sessions des
go
    

create external table mastersys.resource_stats(
/*
test harness:
select top (10000) * from mastersys.resource_stats
*/
    [start_time] datetime2(7)
  , [end_time] datetime2(7)
  , [database_name] nvarchar(128)
  , [sku] nvarchar(128)
  , [storage_in_megabytes] float
  , [avg_cpu_percent] decimal(5, 2)
  , [avg_data_io_percent] decimal(5, 2)
  , [avg_log_write_percent] decimal(5, 2)
  , [max_worker_percent] decimal(5, 2)
  , [max_session_percent] decimal(5, 2)
  , [dtu_limit] int
  , [xtp_storage_percent] decimal(5, 2)
  , [avg_login_rate_percent] decimal(5, 2)
  , [avg_instance_cpu_percent] decimal(5, 2)
  , [avg_instance_memory_percent] decimal(5, 2)
  , [cpu_limit] decimal(5, 2)
  , [allocated_storage_in_megabytes] float
)
with (DATA_SOURCE  = Master, schema_name = N'sys', object_name = N'resource_stats') 
go

go
create or alter procedure mastersys.sp_validatelogins
/* 
test harness:
exec mastersys.sp_validatelogins 
*/
as begin
    select cast(null as varbinary(85)) as SID,
	cast(null as sysname) as [NT login]
    where 1=2
end

go
create external table mastersys.elastic_pool_resource_stats (
/*
test harness:
select top (10000) * from mastersys.elastic_pool_resource_stats
*/
    [start_time] datetime2(7)
  , [end_time] datetime2(7)
  , [elastic_pool_name] nvarchar(128)
  , [avg_cpu_percent] decimal(5, 2)
  , [avg_data_io_percent] decimal(5, 2)
  , [avg_log_write_percent] decimal(5, 2)
  , [avg_storage_percent] decimal(5, 2)
  , [max_worker_percent] decimal(5, 2)
  , [max_session_percent] decimal(5, 2)
  , [elastic_pool_dtu_limit] int
  , [elastic_pool_storage_limit_mb] bigint
  , [max_xtp_storage_percent] decimal(5, 2)
  , [avg_login_rate_percent] decimal(5, 2)
  , [avg_instance_cpu_percent] decimal(5, 2)
  , [avg_instance_memory_percent] decimal(5, 2)
  , [elastic_pool_cpu_limit] decimal(5, 2)
  , [avg_allocated_storage_percent] decimal(5, 2)
)
with (DATA_SOURCE  = Master, schema_name = N'sys', object_name = N'elastic_pool_resource_stats') 

go
create or alter procedure masterdbo.xp_fixeddrives 
/* 
test harness:
exec masterdbo.xp_fixeddrives 
*/
as begin
    select top (1) cast(elastic_pool_name as nvarchar(1)) as drive
    , cast(elastic_pool_storage_limit_mb * (100.0 - avg_storage_percent/100) as decimal(18,2)) as [MB free]
    from mastersys.elastic_pool_resource_stats
    order by start_time desc
end

go
create or alter procedure mastersys.sp_MSforeachdb 
    @command1 NVARCHAR(MAX) = NULL,
    @replacechar NCHAR(1) = N'?' ,
    @command2 NVARCHAR(MAX) = NULL ,
    @command3 NVARCHAR(MAX) = NULL ,
    @precommand NVARCHAR(MAX) = NULL ,
    @postcommand NVARCHAR(MAX) = NULL 
/*
test harness:
exec mastersys.sp_MSforeachdb 'use [?]; select @@version as ''[?]'''
EXEC mastersys.sp_MSforeachdb 'USE [?]; SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; IF EXISTS (SELECT * FROM  sys.tables WITH (NOLOCK) WHERE name = ''sysmergepublications'' ) IF EXISTS ( SELECT * FROM sysmergepublications WITH (NOLOCK) WHERE retention = 0)   INSERT INTO #BlitzResults (CheckID, DatabaseName, Priority, FindingsGroup, Finding, URL, Details) SELECT DISTINCT 99, DB_NAME(), 110, ''Performance'', ''Infinite merge replication metadata retention period'', ''https://BrentOzar.com/go/merge'', (''The ['' + DB_NAME() + ''] database has merge replication metadata retention period set to infinite - this can be the case of significant performance issues.'')';

*/
as begin

   -- do not work: 
   -- call a sligtly modified sp_foreachdb from Aaron Bertrand 
   -- see https://www.mssqltips.com/sqlservertip/2201/making-a-more-reliable-and-flexible-spmsforeachdb/
   -- exec dbo.sp_foreachdb @command = @command1, @replacechar = @replacechar , @command2 = @command2 , @command3 = @command3 , @precommand = @precommand, @postcommand = @postcommand 

   -- just do what-ever you must on this particular database, and nothing else, and don't forget to remove the "use" commands
   set @command1=replace(@command1, 'use [?]', '')
   set @command1=replace(@command1, '[?]', db_name())
   --select @command1 as command1
   exec sp_executesql @command1    
end
go

create or alter procedure mastersys.xp_regread
    @rootkey varchar(100) ='',
    @key varchar(100) ='', 
    @value_name varchar(100) ='', 
    @value varchar(100) ='' output
/*
test harness:
DECLARE @outval VARCHAR(36);
exec mastersys.xp_regread @rootkey = 'HKEY_LOCAL_MACHINE',@key = 'SOFTWARE\Policies\Microsoft\Power\PowerSettings', @value_name = 'ActivePowerScheme', @value = @outval OUTPUT;
select @outval 

*/

as begin
    select @value=@value
end

go
create or alter procedure msdbdbo.sp_send_dbmail
    @recipients VARCHAR(max)
  , @body VARCHAR(MAX)  /* was nvarchar(max) */
  , @subject NVARCHAR(MAX)
  , @debug TINYINT = 10
as begin
    -- figure out a way to simulate the old email function
    -- here is how I did it.
    exec dbo.sp_send_dbmail @recipients = @recipients, @body = @body, @subject = @subject, @debug = @debug     
end

go
CREATE or alter view msdbdbo.backupset 
/*
test harness:
select top (10000) * from msdbdbo.backupset bs ORDER BY backup_start_date ASC;
*/
as
    select top (1)
    cast(1 as int) as backup_set_id   /* tbd */
    , '2020-01-01' as backup_start_date
    , getdate() as backup_finish_date
    , db_name() as database_name
    , cast('f' as char(1)) as type
    , @@SERVERNAME as server_name
    , cast(elastic_pool_storage_limit_mb*(100.0-avg_storage_percent)/100 as decimal(20,0)) as backup_size
    , cast( null as int) as media_set_id
    from mastersys.elastic_pool_resource_stats
  
go
--

CREATE or alter view mastersys.dm_os_sys_memory 
/*
test harness:
select top (10000) * from mastersys.dm_os_sys_memory 
*/
as
    select 
    cast(2147483647 as bigint) as total_physical_memory_kb
    , cast(2147483647 as bigint) as available_physical_memory_kb
go
--
go
CREATE or alter view mastersys.master_files
/*
test harness:
select top (10000) * from mastersys.master_files 
*/
as
    select db_id() as database_id, *
    from sys.database_files df
go

CREATE or alter view mastersys.dm_server_audit_status
/* 
test harness:
select * from mastersys.dm_server_audit_status
*/
as
    select cast('' as sysname) as name
go

CREATE or alter view mastersys.server_permissions
/* 
test harness:
select * from mastersys.server_permissions
*/
as
    select *
    from sys.database_permissions
go

CREATE or alter view mastersys.syslogins
/* 
test harness:
select * from mastersys.syslogins
*/
as
    select * 
    , cast(0 as int ) as securityadmin   /* tbd */
    , cast(0 as int ) as denylogin
    , cast(0 as int ) as sysadmin
    from sys.server_principals sp
go

CREATE or alter view msdbdbo.backupmediafamily
/* 
test harness:
select * from msdbdbo.backupmediafamily
*/
as
    select 
    cast(1 as int) as backup_set_id
    , null as media_set_id
    , cast(null as nvarchar(260)) as physical_device_name

    where 1=2
go

CREATE or alter view msdbdbo.restorehistory
/* 
test harness:
select * from msdbdbo.restorehistory
*/
as
    select 
    cast('' as sysname) as destination_database_name
    , null as restore_date
	, cast(0 as tinyint) as backup_set_id
    where 1=2
go

CREATE or alter view msdbdbo.sysoperators
/* 
test harness:
select * from msdbdbo.sysoperators
*/
as
    select 1 as enabled
go

CREATE or alter view mastersys.server_triggers
/* 
test harness:
select * from mastersys.server_triggers
*/
as
    select '' as name
    , cast(0 as int) as is_disabled
    , cast(0 as int) as is_ms_shipped
    where 1=2
go

CREATE or alter view mastersys.servers
/* 
test harness:
select * from mastersys.servers
*/
as
    select '' as remote_name
    , '' as name
    , cast(0 as int) as server_id
    , cast(0 as int) as is_linked
    , cast(null as 	nvarchar(4000)) as data_source
    , cast(null as sysname) as provider
    where 1=2
go

CREATE or alter view mastersys.linked_logins
/* 
test harness:
select * from mastersys.linked_logins
*/
as
    select '' as remote_name
    , cast(0 as int) as server_id
    , cast(0 as int) as is_ms_shipped
    where 1=2
go

CREATE or alter view mastersys.extended_procedures
/* 
test harness:
select * from mastersys.extended_procedures
select * from sys.extended_procedures
*/
as
    select '' as name
    where 1=2
go

create or alter function mastersys.SUSER_SNAME( @server_user_sid varbinary(85) )
/*
test harness:
select mastersys.SUSER_SNAME(0x01)
*/
returns nvarchar(128)
as begin
    return (
        select case 
            when @server_user_sid = 0x01 then 'sa' 
            when @server_user_sid is null then suser_sname()
            else 'unknown'
            end
        where @server_user_sid is null or @server_user_sid = 0x01
        union all
        select top (1) name from sys.server_principals where sid = @server_user_sid
        )
end
go

create or alter function mastersys.fn_trace_gettable( @filename sysname, @numberoffiles int)
/*
test harness:
select * from mastersys.fn_trace_gettable('test', 1)
*/
RETURNS table
as 
    return (
        select cast('2020-01-01' as date) as starttime
        , cast('2020-01-01' as date) as endtime
        , cast('test' as sysname) as EventClass
        , cast(1 as int) as Severity
        , cast(1 as int) as Duration
        , cast('test' as sysname) as TextData
        , cast('test' as sysname) as DatabaseName
        , cast('test' as sysname) as NTUserName
		, cast('test' as sysname) as NTDomainName
		, cast('test' as sysname) as HostName
		, cast('test' as sysname) as ApplicationName
		, cast('test' as sysname) as LoginName
		, cast('test' as sysname) as DBUserName
    )
go
    
CREATE or alter view msdbsys.all_columns
/* 
test harness:
select * from msdbsys.all_columns 
*/
as
    select '' as name
    where 1=2
go

CREATE or alter view mastersys.server_event_sessions
/* 
test harness:
select * from sys.server_event_sessions
*/
as
    select *
    from sys.database_event_sessions
go

create or alter view mastersys.dm_os_cluster_nodes
/* 
test harness:
select * from sys.dm_os_cluster_nodes
*/
as
    select cast(1 as int) as Status
	, cast('' as nvarchar(20)) as status_description
	, cast(0 as bit) as is_current_owner	
	where 1=2
go

CREATE or alter view msdbdbo.sysschedules
/* 
test harness:
select * from msdbdbo.sysschedules
*/
as
    select '' as name
	, cast(0 as int) as schedule_id
	, cast(0 as int) as job_id
	, cast(0 as int) as freq_type 
	, cast(0 as int) as enabled
    where 1=2
go

CREATE or alter view msdbdbo.sysjobschedules
/* 
test harness:
select * from msdbdbo.sysjobschedules
*/
as
    select '' as name
	, cast(0 as int) as schedule_id
	, cast(0 as int) as job_id
	, cast(0 as int) as next_run_date
    where 1=2
go

CREATE or alter view mastersys.database_mirroring
/* 
test harness:
select * from mastersys.database_mirroring
*/
as
    select '' as name
	, cast(0 as int) as database_id
	, cast(0 as tinyint) as mirroring_role
    where 1=2
go

CREATE or alter view mastersys.dm_os_buffer_pool_extension_configuration
/* 
test harness:
select * from mastersys.dm_os_buffer_pool_extension_configuration
*/
as
    select cast(null as nvarchar(256)) as path
	, cast(null as bigint) as current_size_in_kb
	, cast(null as nvarchar(60)) as state_description
    where 1=2
go

CREATE or alter view mastersys.dm_os_loaded_modules
/* 
test harness:
select * from mastersys.dm_os_loaded_modules
*/
as
    select cast(null as nvarchar(256)) as company
	, cast(null as nvarchar(256)) as description
	, cast(null as nvarchar(256)) as name
    where 1=2
go

CREATE or alter view msdbdbo.sysssispackages
/* 
test harness:
select * from msdbdbo.sysssispackages
*/
as
    select cast(null as image) as packagedata
	, cast(null as uniqueidentifier) as id
	, cast(null as sysname) as name
	, cast(null as int) as packagetype
    where 1=2
go

CREATE or alter view msdbdbo.sysmaintplan_subplans
/* 
test harness:
select * from msdbdbo.sysmaintplan_subplans
*/
as
    select cast(null as uniqueidentifier) as plan_id
	, cast(null as int) as job_id
    where 1=2
go

CREATE or alter view msdbdbo.sysjobsteps
/* 
test harness:
select * from msdbdbo.sysjobsteps
*/
as
    select cast(null as uniqueidentifier) as plan_id
	, cast(null as int) as job_id
	, cast(null as int) as step_id
	, cast(null as sysname) as step_name	
	, cast(null as nvarchar(max) ) as command
    where 1=2
go

CREATE or alter view msdbdbo.sysjobhistory
/* 
test harness:
select * from msdbdbo.sysjobhistory
*/
as
    select cast(null as int) as job_id
	, cast(null as int) as step_id
	, cast(null as int) as run_date
	, cast(null as int) as run_time
	, cast(null as sysname) as step_name
    where 1=2
go
