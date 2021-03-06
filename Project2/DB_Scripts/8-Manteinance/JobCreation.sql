use [msdb]

GO
use [master]

GO
USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'JobBackupFull', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'TECBASES\cluadm', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'JobBackupFull', @server_name = N'DEVSQLCLU'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'JobBackupFull', @step_name=N'StepBackupFull', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @theDate NVARCHAR(MAX)
SET @theDate = N''\\DEVSQLCLU\openfolder\backups\BASESTEC_'' +
 (SELECT replace(CONVERT(VARCHAR(10), GETDATE(), 120),''-'',''_'')) +
 N''-'' + (SELECT replace(CONVERT(VARCHAR(10), GETDATE(), 108),'':'',''_'')) + N''.bak''
BACKUP DATABASE [BASESTEC] 
TO  DISK =  @theDate 
WITH  DESCRIPTION = N''Prueba backup'', 
NOFORMAT, NOINIT,  
NAME = N''BASESTEC-Full Database Backup'', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10, CHECKSUM
GO
', 
		@database_name=N'master', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'JobBackupFull', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'TECBASES\cluadm', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
