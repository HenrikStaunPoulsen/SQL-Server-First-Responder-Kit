drop PROCEDURE if exists dbo.sp_blitz4AzureSQLDB

/* this code will drop add the modules that I've added */
drop procedure if exists msdbdbo.sp_send_dbmail
drop procedure if exists masterdbo.xp_fixeddrives 
drop procedure if exists masterdbo.sp_MSforeachdb 
drop procedure if exists mastersys.xp_regread

--drop EXTERNAL TABLE mastersys.dm_exec_sessions
drop view if exists mastersys.dm_exec_sessions
drop view if exists msdbdbo.sysalerts

drop EXTERNAL TABLE modelsys.tables
drop EXTERNAL TABLE msdbsys.tables
drop EXTERNAL TABLE mastersys.tables
drop EXTERNAL TABLE mastersys.resource_stats
drop EXTERNAL TABLE mastersys.elastic_pool_resource_stats
drop view if exists mastersys.databases
drop external table mastersys.databases_raw
drop EXTERNAL TABLE mastersys.sql_logins
drop EXTERNAL TABLE mastersys.event_log
drop view if exists masterINFORMATION_SCHEMA.columns
drop external table masterINFORMATION_SCHEMA.ROUTINES
drop view if exists msdbINFORMATION_SCHEMA.columns
drop view if exists mastersys.dm_exec_sessions
drop view if exists msdbdbo.sysjobs
drop external table msdbsys.all_objects
drop external table mastersys.all_objects
drop view if exists mastersys.dm_exec_connections
drop view if exists mastersys.dm_os_sys_memory 
drop view if exists mastersys.dm_server_audit_status
drop view if exists mastersys.extended_procedures
drop function if exists mastersys.fn_trace_gettable
drop view if exists mastersys.linked_logins
drop view if exists mastersys.master_files
drop view if exists mastersys.server_permissions
drop view if exists mastersys.server_triggers
drop view if exists mastersys.servers
drop procedure if exists mastersys.sp_MSforeachdb
drop function if exists mastersys.SUSER_SNAME
drop view if exists mastersys.syslogins
drop view if exists mastersys.server_event_sessions

drop view if exists msdbsys.all_columns
drop view if exists msdbdbo.backupmediafamily
drop view if exists msdbdbo.backupset
drop view if exists msdbdbo.restorehistory
drop view if exists msdbdbo.sysoperators
drop procedure if exists mastersys.sp_validatelogins
drop view if exists mastersys.dm_os_cluster_nodes
drop view if exists msdbdbo.sysschedules
drop view if exists msdbdbo.sysjobschedules
drop view if exists mastersys.database_mirroring
drop view if exists mastersys.dm_os_buffer_pool_extension_configuration
drop view if exists mastersys.dm_os_loaded_modules
drop view if exists msdbdbo.sysssispackages
drop view if exists msdbdbo.sysmaintplan_subplans
drop view if exists msdbdbo.sysjobhistory

exec ('drop schema mastersys')
exec ('drop schema modelsys')
exec ('drop schema msdbsys')
exec ('drop schema msdbdbo')
exec ('drop schema msdbinformation_schema')
exec ('drop schema masterINFORMATION_SCHEMA')
exec ('drop schema masterdbo')

DROP EXTERNAL DATA SOURCE [Master]
drop DATABASE SCOPED CREDENTIAL myCred
-- this too?
--drop master key

