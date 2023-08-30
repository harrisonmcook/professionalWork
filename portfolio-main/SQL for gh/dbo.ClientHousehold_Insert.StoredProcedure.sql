USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousehold_Insert]    Script Date: 7/7/2023 9:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousehold_Insert]
			@Id int OUTPUT
           ,@ClientId int
           ,@IsMarried bit
           ,@SpouseName nvarchar(100)
           ,@SpouseLastName nvarchar(100)
           ,@SpouseMi nvarchar(2)
           ,@SpouseDob nvarchar(20)
           ,@SpousePhone nvarchar(20)
           ,@SpouseEmail nvarchar(255)
           ,@hasKids int
           ,@KidsNumber int
           ,@ChildAges nvarchar(2000)
		   ,@CreatedBy int
		   ,@ModifiedBy int
           
as
/*
-- Author: <Harrison Cook>
-- Create date: <06/30/2023>
-- Description: <Inserts into all columns of dbo.ClientHousehold>
-- Code Reviewer:n/A

	DECLARE @Id int =0
           ,@ClientId int=11
           ,@IsMarried bit=1
           ,@SpouseName nvarchar(100)='Michael'
           ,@SpouseLastName nvarchar(100)='Porter'
           ,@SpouseMi nvarchar(2)='L'
           ,@SpouseDob nvarchar(20)='06/29/1998'
           ,@SpousePhone nvarchar(20)='4249876543'
           ,@SpouseEmail nvarchar(255)='michael.porter@gmail.com'
           ,@hasKids int=1
           ,@KidsNumber int=3
           ,@ChildAges nvarchar(2000)='[8,4,3]'
		   ,@CreatedBy int = 1
		   ,@ModifiedBy int = 1
	EXECUTE dbo.ClientHousehold_Insert
			@Id OUTPUT
           ,@ClientId
           ,@IsMarried
           ,@SpouseName
           ,@SpouseLastName
           ,@SpouseMi
           ,@SpouseDob
           ,@SpousePhone
           ,@SpouseEmail
           ,@hasKids
           ,@KidsNumber
           ,@ChildAges
		   ,@CreatedBy 
		   ,@ModifiedBy
	SELECT  CH.Id
           ,Client=(Select * FROM
					dbo.Clients as c
					inner join dbo.ClientHousehold as HD
					on c.Id=HD.ClientId
					where HD.id=CH.id
					FOR JSON AUTO)	
           ,[IsMarried]
           ,[SpouseName]
           ,[SpouseLastName]
           ,[SpouseMi]
           ,[SpouseDob]
           ,[SpousePhone]
           ,[SpouseEmail]
           ,[hasKids]
           ,[KidsNumber]
           ,ChildAges
		   ,[CreatedBy]
		   ,[ModifiedBy]
           ,[DateCreated]
           ,[DateModified]
	FROM dbo.ClientHousehold as CH
	WHERE Id=@Id

	
*/
BEGIN

INSERT INTO [dbo].[ClientHousehold]
           (
            [ClientId]
           ,[IsMarried]
           ,[SpouseName]
           ,[SpouseLastName]
           ,[SpouseMi]
           ,[SpouseDob]
           ,[SpousePhone]
           ,[SpouseEmail]
           ,[hasKids]
           ,[KidsNumber]
           ,[ChildAges]
		   ,[CreatedBy]
		   ,[ModifiedBy])
     VALUES
           (
            @ClientId
           ,@IsMarried
           ,@SpouseName
           ,@SpouseLastName
           ,@SpouseMi
           ,@SpouseDob
           ,@SpousePhone
           ,@SpouseEmail
           ,@hasKids
           ,@KidsNumber
           ,@ChildAges
		   ,@CreatedBy
		   ,@ModifiedBy)
	SET @Id = SCOPE_IDENTITY()
END


GO
