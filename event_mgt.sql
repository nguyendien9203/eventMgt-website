CREATE DATABASE event_mgt

GO

CREATE TABLE [users] (
  [id] INT PRIMARY KEY IDENTITY,
  [username] VARCHAR(20) NOT NULL UNIQUE,
  [password] VARCHAR(100) NOT NULL,
  [created_at] DATETIME,
  [updated_at] DATETIME
)
GO

CREATE TABLE [events] (
  [id] INT PRIMARY KEY IDENTITY,
  [title] NVARCHAR(100),
  [start_datetime] DATE,
  [end_datetime] DATE,
  [location] NVARCHAR(100),
  [description] NVARCHAR(MAX),
  [created_at] DATETIME,
  [updated_at] DATETIME
)
GO

CREATE TABLE [event_user] (
  [event_id] INT,
  [user_id] INT,
  [role] VARCHAR(20),
  [status] VARCHAR(20),
  PRIMARY KEY ([event_id], [user_id])
);

GO

ALTER TABLE [event_user] ADD FOREIGN KEY ([event_id]) REFERENCES [events] ([id])
GO

ALTER TABLE [event_user] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
GO






