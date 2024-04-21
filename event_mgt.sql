CREATE DATABASE event_mgt

GO

CREATE TABLE [categories] (
  [id] INT PRIMARY KEY IDENTITY,
  [category_name] NVARCHAR(20),
  [created_at] DATETIME,
  [updated_at] DATETIME
)
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
  [category_id] INT,
  [title] NVARCHAR(100),
  [location] NVARCHAR(100),
  [start_datetime] DATETIME,
  [end_datetime] DATETIME,
  [description] TEXT,
  [status] VARCHAR(50),
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

ALTER TABLE [events] ADD FOREIGN KEY ([category_id]) REFERENCES [categories] ([id])
GO

ALTER TABLE [event_user] ADD FOREIGN KEY ([event_id]) REFERENCES [events] ([id])
GO

ALTER TABLE [event_user] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
GO






