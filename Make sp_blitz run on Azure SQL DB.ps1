#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass


#$sp_blitz = [pscustomobject] (Get-Content -Raw "F:\SQL\sp_blitz\sp_blitz 20200820.sql") 
$sp_blitz = [pscustomobject] (Get-Content -Raw "F:\SQL\sp_blitz\sp_blitz 20200913.sql") 
$sp_blitz = $sp_blitz -replace 'sp_blitz',                                      'sp_blitz4AzureSQLDB'
$sp_blitz = $sp_blitz -replace 'sp_blitz4AzureSQLDB from',                      'copy of sp_blitz modified for Azure SQL DB as sp_blitz4AzureSQLDB'
$sp_blitz = $sp_blitz.replace('[master]',                                       'master')
$sp_blitz = $sp_blitz.replace('[msdb]',                                         'msdb')
$sp_blitz = $sp_blitz.replace('[dbo]',                                          'dbo')
$sp_blitz = $sp_blitz.replace('[master_files]',                                 'master_files')
$sp_blitz = $sp_blitz -replace 'master.sys.master_files',                       'sys.master_files'
$sp_blitz = $sp_blitz -replace 'EXEC sp_validatelogins',                        'EXEC mastersys.sp_validatelogins'
$sp_blitz = $sp_blitz -replace 'sys.master_files',                              'mastersys.master_files'
$sp_blitz = $sp_blitz -replace 'master.sys',                                    'mastersys'
#$sp_blitz = $sp_blitz -replace 'sys.dm_os_sys_info',                            'mastersys.dm_os_sys_info' removed 20200820, as view is now present
$sp_blitz = $sp_blitz -replace 'msdb.dbo',                                      'msdbdbo'
$sp_blitz = $sp_blitz -replace 'sys.dm_server_audit_status',                    'mastersys.dm_server_audit_status'
$sp_blitz = $sp_blitz -replace 'msdb.INFORMATION',                              'msdbINFORMATION'
$sp_blitz = $sp_blitz -replace 'sys.server_permissions',                        'mastersys.server_permissions'
$sp_blitz = $sp_blitz -replace 'sys.server_triggers',                           'mastersys.server_triggers'
$sp_blitz = $sp_blitz -replace 'sys.servers',                                   'mastersys.servers'
$sp_blitz = $sp_blitz -replace 'msdb.sys',                                      'msdbsys'
$sp_blitz = $sp_blitz -replace 'model.sys',                                     'modelsys'
$sp_blitz = $sp_blitz -replace 'sys.linked_logins',                             'mastersys.linked_logins'
$sp_blitz = $sp_blitz -replace 'sys.dm_os_sys_memory',                          'mastersys.dm_os_sys_memory'
$sp_blitz = $sp_blitz -replace 'sys.dm_os_cluster_nodes',                       'mastersys.dm_os_cluster_nodes'
$sp_blitz = $sp_blitz -replace 'sys.dm_os_buffer_pool_extension_configuration', 'mastersys.dm_os_buffer_pool_extension_configuration'
$sp_blitz = $sp_blitz -replace 'sys.dm_os_loaded_modules',                      'mastersys.dm_os_loaded_modules'
$sp_blitz = $sp_blitz -replace 'dbo.sp_MSforeachdb',                            'mastersys.sp_MSforeachdb'
$sp_blitz = $sp_blitz -replace ' sp_MSforeachdb',                               ' mastersys.sp_MSforeachdb'

$sp_blitz = $sp_blitz -replace 'master.INFORMATION_',                                                 'masterINFORMATION_'
$sp_blitz = $sp_blitz -replace 'master.dbo',                                                          'masterdbo'
$sp_blitz = $sp_blitz -replace 'master\.\.',                                                          ''
$sp_blitz = $sp_blitz -replace 'sys.fn_trace_gettable',                                               'mastersys.fn_trace_gettable'
$sp_blitz = $sp_blitz -replace '::fn_trace_gettable',                                                 'mastersys.fn_trace_gettable'
$sp_blitz = $sp_blitz.replace('CAST(DATEDIFF(HOUR, create_date, GETDATE()) / 24. AS NUMERIC(23, 2))', 'cast(DATEDIFF(HOUR, min(connect_time), GETDATE()) / 24. AS NUMERIC(23, 2))')
$sp_blitz = $sp_blitz.replace('''Azure Managed Instance''',                                           '''Azure SQL database''')
$sp_blitz = $sp_blitz -replace 'sys.databases
		WHERE  database_id = 2;',                                                                     'sys.dm_exec_connections des;'
$sp_blitz = $sp_blitz -replace 'Azure Managed Instance skipped checks ',                              'Azure Managed Instance skipped checks */

		/* If the server is an Azure SQL Database, skip checks that it doesn''t allow */
		IF CAST(SERVERPROPERTY(''Edition'') AS NVARCHAR(1000)) LIKE N''SQL Azure''
			begin
                if @Debug IN (1, 2) RAISERROR(''Skipping some checks because of Azure SQL Database.'', 0, 1) WITH NOWAIT;            
						INSERT INTO #SkipChecks (CheckID) VALUES (1);  /* Full backups  */
						INSERT INTO #SkipChecks (CheckID) VALUES (2);  /* Log backups  */
						INSERT INTO #SkipChecks (CheckID) VALUES (6);  /* Security */
						INSERT INTO #SkipChecks (CheckID) VALUES (10);  /* no resource governor present */
						INSERT INTO #SkipChecks (CheckID) VALUES (21);  /* Informational - Database Encrypted per https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/issues/1919 */
						INSERT INTO #SkipChecks (CheckID) VALUES (24);  /* File Configuration - System Database on C Drive per https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/issues/1919 */
						INSERT INTO #SkipChecks (CheckID) VALUES (30);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (50);  /* Max Server Memory Set Too High - because they max it out */
						INSERT INTO #SkipChecks (CheckID) VALUES (53);  /* no dm_os_cluster_nodes*/
						INSERT INTO #SkipChecks (CheckID) VALUES (55);  /* Security - Database Owner <> sa per https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/issues/1919 */
						INSERT INTO #SkipChecks (CheckID) VALUES (57);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (59);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (61);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (68);  /* no DBCC dbinfo, TBD: use sys.dm_db_?? instead */
						INSERT INTO #SkipChecks (CheckID) VALUES (69);  /* no DBCC loginfo, TBD: use sys.dm_db_log_info instead */
                        INSERT INTO #SkipChecks (CheckID) VALUES (73);  /* no Failsafe operator */
						INSERT INTO #SkipChecks (CheckID) VALUES (74);  /* TraceFlag On - because Azure SQLDB go wild and crazy with the trace flags */
						INSERT INTO #SkipChecks (CheckID) VALUES (79);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (92);  /* no fixed drives present */
						INSERT INTO #SkipChecks (CheckID) VALUES (94);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (96);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (97);  /* Unusual SQL Server Edition */
						INSERT INTO #SkipChecks (CheckID) VALUES (98);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (99);  /* no sysmergepublications */
						INSERT INTO #SkipChecks (CheckID) VALUES (100);  /* Remote DAC disabled - but it''s working anyway, details here: https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/issues/1481 */
						INSERT INTO #SkipChecks (CheckID) VALUES (105);  /* no extended_procedures*/
                        INSERT INTO #SkipChecks (CheckID) VALUES (106);  /* no fn_trace_gettable */
						INSERT INTO #SkipChecks (CheckID) VALUES (111);  /* no database_mirroring */
						INSERT INTO #SkipChecks (CheckID) VALUES (116);  /* no msdb.all_columns, no compressed_backup_size */
						INSERT INTO #SkipChecks (CheckID) VALUES (123);  /* no sysjobactivity */
						INSERT INTO #SkipChecks (CheckID) VALUES (128);  /* no old SQL Server builds on this platform */ 
						INSERT INTO #SkipChecks (CheckID) VALUES (129);  /* no old SQL Server builds on this platform */ 
						INSERT INTO #SkipChecks (CheckID) VALUES (154);  /* 32 bit is not a problem */
						INSERT INTO #SkipChecks (CheckID) VALUES (157);  /* no old SQL Server builds on this platform */ 
						INSERT INTO #SkipChecks (CheckID) VALUES (166);  /* no dm_os_process_memory*/
						INSERT INTO #SkipChecks (CheckID) VALUES (174);  /* no dm_os_buffer_pool_extension_configuration */
						INSERT INTO #SkipChecks (CheckID) VALUES (179);  /* no dm_os_loaded_modules */
						INSERT INTO #SkipChecks (CheckID) VALUES (180);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (181);  /* no sysssispackages */
						INSERT INTO #SkipChecks (CheckID) VALUES (184);  /* no dm_os_cluster_nodes*/
						INSERT INTO #SkipChecks (CheckID) VALUES (186);  /* MSDB Backup History Purged Too Frequently */
						INSERT INTO #SkipChecks (CheckID) VALUES (188);  /* cost threshold for parallelism is set to 5, permanently */
						INSERT INTO #SkipChecks (CheckID) VALUES (191);  /* no tempdb number of files problems */
						INSERT INTO #SkipChecks (CheckID) VALUES (199);  /* Default trace, details here: https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit/issues/1481 */
						INSERT INTO #SkipChecks (CheckID) VALUES (211);  /* no Power Plan */
						INSERT INTO #SkipChecks (CheckID) VALUES (213);  /* needs re-write because mastersys.SUSER_SNAME with parameters is not supported. use a left join to sys.database_principals instead  */
						INSERT INTO #SkipChecks (CheckID) VALUES (219);  /* no SQL Agent present */
						INSERT INTO #SkipChecks (CheckID) VALUES (999);  /* no fn_trace_gettable */
						INSERT INTO #SkipChecks (CheckID) VALUES (2301);  /* no sp_validatelogins'' in Azure */
						INSERT INTO #SkipChecks (CheckID, DatabaseName) VALUES (80, ''master'');  /* Max file size set */
						INSERT INTO #SkipChecks (CheckID, DatabaseName) VALUES (80, ''model'');  /* Max file size set */
						INSERT INTO #SkipChecks (CheckID, DatabaseName) VALUES (80, ''msdb'');  /* Max file size set */
						INSERT INTO #SkipChecks (CheckID, DatabaseName) VALUES (80, ''tempdb'');  /* Max file size set */
			            INSERT  INTO #BlitzResults
			            ( CheckID ,
				            Priority ,
				            FindingsGroup ,
				            Finding ,
				            URL ,
				            Details
			            )
			            SELECT 223 AS CheckID ,
					            0 AS Priority ,
					            ''Informational'' AS FindingsGroup ,
					            ''Some Checks Skipped'' AS Finding ,
					            ''https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-index'' AS URL ,
					            ''Azure SQL Database detected, so we skipped some checks that are not currently possible, relevant, or practical there.'' AS Details;
            END; /* Azure SQL database skipped checks '


$sp_blitz = $sp_blitz -replace ', 1065 \);',                               ', 1065 );

        		IF CAST(SERVERPROPERTY(''Edition'') AS NVARCHAR(1000)) LIKE N''SQL Azure''
		    	begin /* defaults have changed on Azure SQL Database */
                    UPDATE #ConfigurationDefaults SET DefaultValue = 20 WHERE NAME = ''blocked process threshold (s)'';
                    UPDATE #ConfigurationDefaults SET DefaultValue =  1 WHERE NAME = ''clr enabled'';
                    UPDATE #ConfigurationDefaults SET DefaultValue =  0 WHERE NAME = ''default trace enabled'';
                END
'    
$sp_blitz = $sp_blitz -replace 'DECLARE DatabaseDefaultsLoop',                                        'IF CAST(SERVERPROPERTY(''Edition'') AS NVARCHAR(1000)) LIKE N''SQL Azure''
			            BEGIN /* defaults have changed on Azure SQL Database */
                            UPDATE #DatabaseDefaults SET DefaultValue=1 WHERE NAME = ''is_broker_enabled'';
                            UPDATE #DatabaseDefaults SET DefaultValue=1 WHERE NAME = ''snapshot_isolation_state''
                        END

						DECLARE DatabaseDefaultsLoop'
$sp_blitz = $sp_blitz.replace('sys.databases d ON d.name = ''tempdb',                                 'mastersys.databases d ON d.name = ''tempdb')
$sp_blitz = $sp_blitz -replace 'SUSER_SNAME',                                                         'mastersys.SUSER_SNAME'

$sp_blitz = $sp_blitz -replace 'dm_xe_sessions',                                                      'dm_xe_database_sessions'
$sp_blitz = $sp_blitz -replace 'sys.server_event_sessions',                                           'mastersys.server_event_sessions'
$sp_blitz = $sp_blitz -replace 'AND name NOT IN ',                                                    'AND name collate database_default NOT IN '

#$sp_blitz = $sp_blitz -replace 'a', 'b'
#$sp_blitz = $sp_blitz -replace 'a', 'b'

#$sp_blitz 
#$sp_blitz | Export-Csv -NoTypeInformation -Encoding Utf8 "C:\Users\hsp.CORP\OneDrive - InsuBiz ApS\Dokumenter\SQL\sp_blitz for Azure 20200602.sql"
#$sp_blitz | Set-content "C:\Users\hsp.CORP\OneDrive - InsuBiz ApS\Dokumenter\SQL\sp_blitz for Azure 20200602.sql"
#$sp_blitz | Set-content "C:\Users\hsp.CORP\OneDrive - InsuBiz ApS\Dokumenter\SQL\sp_blitz for Azure 20200820.sql"
$sp_blitz | Set-content "F:\SQL\sp_blitz\sp_blitz for Azure 20200913.sql"



#$sp_blitz = [pscustomobject] (Get-Content -Raw "C:\Users\hsp.CORP\OneDrive - InsuBiz ApS\Dokumenter\SQL\sp_ineachdb 20200821.sql") 
$sp_blitz = [pscustomobject] (Get-Content -Raw "F:\SQL\sp_blitz\sp_ineachdb 20200913.sql") 
$sp_blitz = $sp_blitz -replace 'master.sys',                 'mastersys'
$sp_blitz | Set-content "F:\SQL\sp_blitz\sp_ineachdb for Azure 20200913.sql"
