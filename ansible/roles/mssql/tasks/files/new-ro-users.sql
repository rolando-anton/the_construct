EXEC SP_ADDLOGIN 'AOPerfLogin', 'ProspectHills!', 'master';
EXEC SP_ADDROLE 'AOPerfRole';
EXEC SP_ADDUSER 'AOPerfLogin', 'AOPerfUser', 'AOPerfRole';
GRANT VIEW SERVER STATE TO AOPerfLogin;
GRANT SELECT ON dbo.sysperfinfo TO AOPerfRole;
GRANT EXEC on xp_readerrorlog to AOPerfRole

USE [PH_Events]
GO
EXEC SP_ADDLOGIN 'AOAuditLogin', 'ProspectHills!', 'PH_Events';
EXEC SP_ADDROLE 'AOAuditRole';
EXEC SP_ADDUSER 'AOAuditLogin', 'AOAuditUser', 'AOAuditRole';
GRANT VIEW DATABASE STATE TO AOAuditRole;
GRANT SELECT ON dbo.DDLEvents TO AOAuditRole;
GRANT SELECT ON dbo.LogonEvents TO AOAuditRole;
