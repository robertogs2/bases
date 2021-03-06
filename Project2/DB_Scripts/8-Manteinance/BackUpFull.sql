DECLARE @theDate NVARCHAR(MAX)
SET @theDate = N'\\DEVSQLCLU\openfolder\backups\BASESTEC_' +
 (SELECT replace(CONVERT(VARCHAR(10), GETDATE(), 120),'-','_')) +
 N'-' + (SELECT replace(CONVERT(VARCHAR(10), GETDATE(), 108),':','_')) + N'.bak'
BACKUP DATABASE [BASESTEC] 
TO  DISK =  @theDate 
WITH  DESCRIPTION = N'Prueba backup', 
NOFORMAT, NOINIT,  
NAME = N'BASESTEC-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10, CHECKSUM
GO
