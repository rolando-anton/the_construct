/****** PATH is intented to work on MSSQL 2014 Express ******/

CREATE DATABASE [SuperSecureBank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SuperSecureBank', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SuperSecureBank.mdf' , SIZE = 4096KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SuperSecureBank_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\SuperSecureBank_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SuperSecureBank] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [SuperSecureBank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SuperSecureBank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SuperSecureBank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SuperSecureBank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SuperSecureBank] SET ARITHABORT OFF 
GO
ALTER DATABASE [SuperSecureBank] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SuperSecureBank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SuperSecureBank] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [SuperSecureBank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SuperSecureBank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SuperSecureBank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SuperSecureBank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SuperSecureBank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SuperSecureBank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SuperSecureBank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SuperSecureBank] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SuperSecureBank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SuperSecureBank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SuperSecureBank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SuperSecureBank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SuperSecureBank] SET  READ_WRITE 
GO
ALTER DATABASE [SuperSecureBank] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SuperSecureBank] SET  MULTI_USER 
GO
ALTER DATABASE [SuperSecureBank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SuperSecureBank] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SuperSecureBank] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SuperSecureBank]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [SuperSecureBank] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO


USE [SuperSecureBank]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[errorID] [bigint] IDENTITY(1,9431114) NOT NULL,
	[time] [datetime] NOT NULL,
	[errorText] [text] NOT NULL,
	[exception] [text] NOT NULL,
 CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[errorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[commentID] [bigint] IDENTITY(1,1) NOT NULL,
	[userID] [bigint] NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[body] [text] NOT NULL,
	[postTime] [datetime] NOT NULL,
	[Validated] [bit] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[commentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTypes](
	[type] [bigint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [text] NOT NULL,
	[IsLoan] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountStatus]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountStatus](
	[status] [bigint] NOT NULL,
	[Description] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[accountID] [bigint] IDENTITY(3512143,1) NOT NULL,
	[userID] [bigint] NOT NULL,
	[type] [bigint] NOT NULL,
	[balance] [bigint] NOT NULL,
	[level] [bigint] NOT NULL,
	[status] [bigint] NOT NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[accountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountLevels]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountLevels](
	[level] [bigint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [bigint] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sessions]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sessions](
	[userID] [bigint] NOT NULL,
	[sessionID] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[FriendlyAccounts]    Script Date: 10/20/2011 16:41:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FriendlyAccounts]
AS
SELECT        dbo.Users.userID, dbo.Accounts.accountID, dbo.Accounts.balance, dbo.AccountLevels.Name AS LevelName, dbo.AccountLevels.Description AS LevelDescription, 
                         dbo.AccountTypes.Name AS TypeName, dbo.AccountTypes.Description AS TypeDescription, dbo.AccountStatus.Description AS Status
FROM            dbo.Users INNER JOIN
                         dbo.Accounts ON dbo.Users.userID = dbo.Accounts.userID INNER JOIN
                         dbo.AccountLevels ON dbo.Accounts.level = dbo.AccountLevels.level INNER JOIN
                         dbo.AccountTypes ON dbo.Accounts.type = dbo.AccountTypes.type INNER JOIN
                         dbo.AccountStatus ON dbo.Accounts.status = dbo.AccountStatus.status
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Accounts"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 135
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountLevels"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 118
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountTypes"
            Begin Extent = 
               Top = 6
               Left = 662
               Bottom = 118
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountStatus"
            Begin Extent = 
               Top = 6
               Left = 870
               Bottom = 101
               Right = 1040
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3480
         Width = 1755
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FriendlyAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'00
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FriendlyAccounts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FriendlyAccounts'
GO
/****** Object:  Default [DF_Accounts_status]    Script Date: 10/20/2011 16:41:32 ******/
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_status]  DEFAULT ((0)) FOR [status]
GO
/****** Object:  Default [DF_AccountTypes_Description]    Script Date: 10/20/2011 16:41:32 ******/
ALTER TABLE [dbo].[AccountTypes] ADD  CONSTRAINT [DF_AccountTypes_Description]  DEFAULT ('No description') FOR [Description]
GO
/****** Object:  Default [DF_AccountTypes_IsLoan]    Script Date: 10/20/2011 16:41:32 ******/
ALTER TABLE [dbo].[AccountTypes] ADD  CONSTRAINT [DF_AccountTypes_IsLoan]  DEFAULT ((0)) FOR [IsLoan]
GO
/****** Object:  Default [DF_Comments_Validated]    Script Date: 10/20/2011 16:41:32 ******/
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_Comments_Validated]  DEFAULT ((0)) FOR [Validated]
GO
/****** Object:  Default [DF_ErrorLog_time]    Script Date: 10/20/2011 16:41:32 ******/
ALTER TABLE [dbo].[ErrorLog] ADD  CONSTRAINT [DF_ErrorLog_time]  DEFAULT (getdate()) FOR [time]
GO


-- `dbo.AccountLevels`
INSERT dbo.AccountLevels VALUES (0, N'Basic', 'Zero Interest Rate')
INSERT dbo.AccountLevels VALUES (1, N'Standard', 'Zero Interest Rate, Check Card')
INSERT dbo.AccountLevels VALUES (2, N'Advanced', 'Zero Interest Rate, Check Card, Free Credit Card')
INSERT dbo.AccountLevels VALUES (3, N'Silver', 'Customers who want basic banking options, maintain smaller balances and don''t want to manage too many details.<ul><li>No monthly fees</li><li>Preferred loan rates</li><li>No-fee credit card</li></ul>')
INSERT dbo.AccountLevels VALUES (4, N'Gold', 'Customers with growing financial needs who are looking for a simple, comprehensive and superior value solution.	<ul><li>25% rewards bonus for SuperSecure Bank Check Card and Credit Card use</li><li>Preferred loan rates</li><li>No fees on the first overdraft occasion</li><li>Two free non-SuperSecure Bank ATM transactions for SuperSecure Bank Gold Checking</li></ul>')
INSERT dbo.AccountLevels VALUES (5, N'Platinum', 'Customers with higher account balances who want to maintain their financial strength.<ul><li>Preferred interest and loan rates</li><li>50% monthly bonus on all rewards earned for net purchases</li><li>Unlimited free non-SuperSecure Bank ATM transactions</li></ul>')

-- `dbo.Accounts`
SET IDENTITY_INSERT dbo.Accounts ON

INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512144, 1, 0, 2812, 0, 0)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512145, 1, 3, 12000, 1, 0)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512146, 1, 2, 0, 0, 3)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512147, 5, 5, -500000, 5, 1)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512148, 5, 8, -5000, 0, 1)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512149, 5, 7, -400, 1, 1)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512150, 5, 0, 1100, 2, 0)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512151, 6, 8, -45500, 5, 0)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512152, 5, 1, 0, 1, 0)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512153, 7, 0, 0, 0, 1)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512154, 7, 0, 0, 0, 1)
INSERT dbo.Accounts (accountID, userID, type, balance, [level], status) VALUES (3512155, 7, 3, 11110000, 5, 1)
SET IDENTITY_INSERT dbo.Accounts OFF


-- `dbo.AccountStatus`
INSERT dbo.AccountStatus VALUES (0, N'Active')
INSERT dbo.AccountStatus VALUES (1, N'Pending')
INSERT dbo.AccountStatus VALUES (2, N'Denied')
INSERT dbo.AccountStatus VALUES (3, N'Under Review')
INSERT dbo.AccountStatus VALUES (4, N'Issues Found')
INSERT dbo.AccountStatus VALUES (5, N'Waiting for Resolution')
INSERT dbo.AccountStatus VALUES (6, N'Issue: 57192785')
INSERT dbo.AccountStatus VALUES (7, N'Not my fault')
INSERT dbo.AccountStatus VALUES (8, N'This should never happen')

-- `dbo.AccountTypes`
INSERT dbo.AccountTypes VALUES (0, N'Student Checking', 'Checking especially for college students', 0)
INSERT dbo.AccountTypes VALUES (1, N'Advantage Checking', 'Premium rates with the best benefits and discounts we offer', 0)
INSERT dbo.AccountTypes VALUES (2, N'Online Savings', 'A great way to start saving automatically with an opportunity to receive a premium interest rate on your Online Savings Account', 0)
INSERT dbo.AccountTypes VALUES (3, N'Money Market Savings', 'Competitive rates and easy access to your money with the option to write checks', 0)
INSERT dbo.AccountTypes VALUES (4, N'CD', 'A guaranteed return with fixed rates and a choice of terms', 0)
INSERT dbo.AccountTypes VALUES (5, N'Home Loan', 'Whether you are buying or refinancing, our ', 1)
INSERT dbo.AccountTypes VALUES (6, N'Home Equity', 'Put the equity in your home to work for', 1)
INSERT dbo.AccountTypes VALUES (7, N'Student Loans', 'Finance your or your children''s education.', 1)
INSERT dbo.AccountTypes VALUES (8, N'Credit Card', 'Enjoy low introductory rates, optional rewards and great SuperSecureBank Service!', 1)

-- `dbo.Comments`
SET IDENTITY_INSERT dbo.Comments ON

INSERT dbo.Comments (commentID, userID, title, body, postTime, Validated) VALUES (15, 5, N'super secure bank is great!', 'I love this bank!', '20110525 11:46:52:000', 0)
INSERT dbo.Comments (commentID, userID, title, body, postTime, Validated) VALUES (16, 5, N'New Comment', 'This one will show up!', '20110525 11:51:29:000', 1)
INSERT dbo.Comments (commentID, userID, title, body, postTime, Validated) VALUES (17, 5, N'test', 'test', '20110525 11:53:03:000', 0)
SET IDENTITY_INSERT dbo.Comments OFF


-- `dbo.Users`
SET IDENTITY_INSERT dbo.Users ON

INSERT dbo.Users (userID, userName, email, password) VALUES (1, N'admin', N'admin', N'admin')
INSERT dbo.Users (userID, userName, email, password) VALUES (5, N'joe', N'joe@whoisjoe.net', N'letmein')
INSERT dbo.Users (userID, userName, email, password) VALUES (7, N'test', N'test', N'test')
INSERT dbo.Users (userID, userName, email, password) VALUES (8, N'username', N'test@test.com', N'password')
INSERT dbo.Users (userID, userName, email, password) VALUES (9, N'jim', N'pass', N'')
INSERT dbo.Users (userID, userName, email, password) VALUES (10, N'asdf', N'asdf', N'asdf')
INSERT dbo.Users (userID, userName, email, password) VALUES (11, N'newJoe', N'newJoe@example.com', N'pass')
INSERT dbo.Users (userID, userName, email, password) VALUES (12, N'newJoe', N'newJoe@example.com', N'pass')
INSERT dbo.Users (userID, userName, email, password) VALUES (13, N'newJoe', N'newJoe@example.com', N'pass')
INSERT dbo.Users (userID, userName, email, password) VALUES (14, N'test2', N'test@test.com', N'ASDF')
INSERT dbo.Users (userID, userName, email, password) VALUES (15, N'asdffefe', N'joe@joe.com', N'asdf')
SET IDENTITY_INSERT dbo.Users OFF

