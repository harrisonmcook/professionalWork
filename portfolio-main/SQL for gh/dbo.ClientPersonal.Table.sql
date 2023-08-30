USE [YellowBrick]
GO
/****** Object:  Table [dbo].[ClientPersonal]    Script Date: 8/2/2023 11:24:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientPersonal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[BirthPlaceCountryId] [int] NOT NULL,
	[BirthPlaceCity] [nvarchar](50) NOT NULL,
	[SSN] [nvarchar](20) NULL,
	[EmployerLocationId] [int] NULL,
	[EmployerPhone] [nvarchar](20) NULL,
	[HomeLocationId] [int] NOT NULL,
	[MailingLocationId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ClientPersonal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_ClientPersonal] UNIQUE NONCLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientPersonal] ADD  CONSTRAINT [DF_ClientPersonal_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[ClientPersonal] ADD  CONSTRAINT [DF_ClientPersonal_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[ClientPersonal] ADD  CONSTRAINT [DF_ClientPersonal_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[ClientPersonal]  WITH CHECK ADD  CONSTRAINT [FK_ClientPersonal_ClientPersonal] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
GO
ALTER TABLE [dbo].[ClientPersonal] CHECK CONSTRAINT [FK_ClientPersonal_ClientPersonal]
GO
ALTER TABLE [dbo].[ClientPersonal]  WITH CHECK ADD  CONSTRAINT [FK_ClientPersonal_Countries] FOREIGN KEY([BirthPlaceCountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[ClientPersonal] CHECK CONSTRAINT [FK_ClientPersonal_Countries]
GO
ALTER TABLE [dbo].[ClientPersonal]  WITH CHECK ADD  CONSTRAINT [FK_ClientPersonal_Locations] FOREIGN KEY([HomeLocationId])
REFERENCES [dbo].[Locations] ([Id])
GO
ALTER TABLE [dbo].[ClientPersonal] CHECK CONSTRAINT [FK_ClientPersonal_Locations]
GO
ALTER TABLE [dbo].[ClientPersonal]  WITH CHECK ADD  CONSTRAINT [FK_ClientPersonal_Locations1] FOREIGN KEY([MailingLocationId])
REFERENCES [dbo].[Locations] ([Id])
GO
ALTER TABLE [dbo].[ClientPersonal] CHECK CONSTRAINT [FK_ClientPersonal_Locations1]
GO
ALTER TABLE [dbo].[ClientPersonal]  WITH CHECK ADD  CONSTRAINT [FK_ClientPersonal_StatusTypes] FOREIGN KEY([StatusId])
REFERENCES [dbo].[StatusTypes] ([Id])
GO
ALTER TABLE [dbo].[ClientPersonal] CHECK CONSTRAINT [FK_ClientPersonal_StatusTypes]
GO
ALTER TABLE [dbo].[ClientPersonal]  WITH CHECK ADD  CONSTRAINT [FK_ClientPersonal_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ClientPersonal] CHECK CONSTRAINT [FK_ClientPersonal_Users]
GO
ALTER TABLE [dbo].[ClientPersonal]  WITH CHECK ADD  CONSTRAINT [FK_ClientPersonal_Users1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ClientPersonal] CHECK CONSTRAINT [FK_ClientPersonal_Users1]
GO
