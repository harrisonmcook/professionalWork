﻿USE [YellowBrick]
GO
//****** Object:  Table [dbo].[ClientHousehold]    Script Date: 7/7/2023 9:20:29 AM ******//
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientHousehold](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[IsMarried] [bit] NOT NULL,
	[SpouseName] [nvarchar](100) NULL,
	[SpouseLastName] [nvarchar](100) NULL,
	[SpouseMi] [nvarchar](2) NULL,
	[SpouseDOB] [nvarchar](20) NULL,
	[SpousePhone] [nvarchar](20) NULL,
	[SpouseEmail] [nvarchar](255) NULL,
	[HasKids] [bit] NOT NULL,
	[KidsNumber] [int] NULL,
	[ChildAges] [nvarchar](2000) NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ClientHousehold] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientHousehold] ADD  CONSTRAINT [DF_ClientHousehold_IsMarried]  DEFAULT ((0)) FOR [IsMarried]
GO
ALTER TABLE [dbo].[ClientHousehold] ADD  CONSTRAINT [DF_ClientHousehold_hasKids]  DEFAULT ((0)) FOR [HasKids]
GO
ALTER TABLE [dbo].[ClientHousehold] ADD  CONSTRAINT [DF_ClientHousehold_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[ClientHousehold] ADD  CONSTRAINT [DF_ClientHousehold_CreatedBy]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ClientHousehold] ADD  CONSTRAINT [DF_ClientHousehold_ModifiedBy]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[ClientHousehold]  WITH CHECK ADD  CONSTRAINT [FK_ClientHousehold_StatusTypes] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusTypes] ([Id])
GO
ALTER TABLE [dbo].[ClientHousehold] CHECK CONSTRAINT [FK_ClientHousehold_StatusTypes]
GO
