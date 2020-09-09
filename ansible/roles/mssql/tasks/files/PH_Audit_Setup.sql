USE master;
GO
CREATE DATABASE PH_Events;
GO
CREATE TABLE PH_Events.dbo.DDLEvents
(
	XMLEvent XML,
	DatabaseName NVARCHAR(64),
	EventTime DATETIME DEFAULT (GETDATE()),
	EventType NVARCHAR(128),
	SPID NVARCHAR(128),
	ServerName NVARCHAR(128),
	LoginName NVARCHAR(128),
	ObjectName NVARCHAR(128),
	ObjectType NVARCHAR(128),
	SchemaName NVARCHAR(128),
	CommandText NVARCHAR(MAX)
);
GO
CREATE TABLE PH_Events.dbo.LogonEvents
(
	XMLEvent XML,
	EventTime DATETIME,
	EventType NVARCHAR(128),
	SPID NVARCHAR(128),
	ServerName NVARCHAR(128),
	LoginName NVARCHAR(128),
	LoginType NVARCHAR(128),
	SID NVARCHAR(128),
	HostName NVARCHAR(128),
	IsPooled NVARCHAR(128),
	AppName NVARCHAR(255)
);
GO

CREATE TRIGGER PH_Database_Level_Events on DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS
DECLARE @eventData AS XML;
SET @eventData = EVENTDATA();
INSERT INTO PH_Events.dbo.DDLEvents(EventTime, EventType, SPID, ServerName, LoginName, ObjectName, ObjectType, SchemaName, DatabaseName, CommandText, XMLEvent)
VALUES(cast(@eventData.query('data(//PostTime)') AS NVARCHAR(64)),
       cast(@eventData.query('data(//EventType)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//SPID)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//ServerName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//LoginName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//ObjectName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//ObjectType)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//SchemaName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//DatabaseName)') AS NVARCHAR(64)),
	   cast(@eventData.query('data(//TSQLCommand/CommandText)') AS NVARCHAR(MAX)),
	   @eventData
);
GO

CREATE TRIGGER PH_DDL_Server_Level_Events ON ALL SERVER
FOR DDL_ENDPOINT_EVENTS, DDL_LOGIN_EVENTS, DDL_GDR_SERVER_EVENTS, DDL_AUTHORIZATION_SERVER_EVENTS, CREATE_DATABASE, ALTER_DATABASE, DROP_DATABASE
/**FOR DDL_SERVER_LEVEL_EVENTS**/
AS
DECLARE @eventData AS XML;
SET @eventData = EVENTDATA();
/**declare @eventData as XML; set @eventData = EVENTDATA();**/
INSERT INTO PH_Events.dbo.DDLEvents(EventTime, EventType, SPID, ServerName, LoginName, ObjectName, ObjectType, SchemaName, DatabaseName, CommandText, XMLEvent)
VALUES(cast(@eventData.query('data(//PostTime)') AS NVARCHAR(64)),
	   cast(@eventData.query('data(//EventType)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//SPID)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//ServerName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//LoginName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//ObjectName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//ObjectType)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//SchemaName)') AS NVARCHAR(128)),
	   cast(@eventData.query('data(//DatabaseName)') AS NVARCHAR(64)),
	   cast(@eventData.query('data(//TSQLCommand/CommandText)') AS NVARCHAR(MAX)),
	   /** DB_NAME(),**/
	   @eventData);
GO

CREATE TRIGGER PH_LoginEvents
ON ALL SERVER WITH EXECUTE AS self
FOR LOGON
AS
BEGIN
DECLARE @event XML
SET @event = EVENTDATA()
INSERT INTO PH_Events.dbo.LogonEvents(EventTime, EventType, SPID, ServerName, LoginName, LoginType, SID, HostName, IsPooled, AppName, XMLEvent)
VALUES(CAST(CAST(@event.query('/EVENT_INSTANCE/PostTime/text()') AS NVARCHAR(64)) AS DATETIME),
       CAST(@event.query('/EVENT_INSTANCE/EventType/text()') AS NVARCHAR(128)),
	   CAST(@event.query('/EVENT_INSTANCE/SPID/text()') AS NVARCHAR(128)),
	   CAST(@event.query('/EVENT_INSTANCE/ServerName/text()') AS NVARCHAR(128)),
	   CAST(@event.query('/EVENT_INSTANCE/LoginName/text()') AS NVARCHAR(128)),
	   CAST(@event.query('/EVENT_INSTANCE/LoginType/text()') AS NVARCHAR(128)),
	   CAST(@event.query('/EVENT_INSTANCE/SID/text()') AS NVARCHAR(128)),
	   CAST(@event.query('/EVENT_INSTANCE/ClientHost/text()') AS NVARCHAR(128)),
	   CAST(@event.query('/EVENT_INSTANCE/IsPooled/text()') AS NVARCHAR(128)), APP_NAME(), @event)
END;
GO
