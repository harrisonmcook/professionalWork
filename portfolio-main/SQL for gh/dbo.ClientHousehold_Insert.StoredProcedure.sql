﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousehold_Insert]    Script Date: 7/7/2023 9:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousehold_Insert]
	    @Id int OUTPUT
           ,@ClientId INT
           ,@IsMarried BIT
           ,@SpouseName NVARCHAR(100)
           ,@SpouseLastName NVARCHAR(100)
           ,@SpouseMi NVARCHAR(2)
           ,@SpouseDob NVARCHAR(20)
           ,@SpousePhone NVARCHAR(20)
           ,@SpouseEmail NVARCHAR(255)
           ,@hasKids INT
           ,@KidsNumber INT
           ,@ChildAges NVARCHAR(2000)
	   ,@CreatedBy INT
	   ,@ModifiedBy INT
           
as
/*
-- Author: <Harrison Cook>
-- Create date: <06/30/2023>
-- Description: <Inserts into all columns of dbo.ClientHousehold>
-- Code Reviewer:n/A

	DECLARE @Id int =0
           ,@ClientId INT=11
           ,@IsMarried BIT=1
           ,@SpouseName NVARCHAR(100)='Michael'
           ,@SpouseLastName NVARCHAR(100)='Porter'
           ,@SpouseMi NVARCHAR(2)='L'
           ,@SpouseDob NVARCHAR(20)='06/29/1998'
           ,@SpousePhone NVARCHAR(20)='4249876543'
           ,@SpouseEmail NVARCHAR(255)='michael.porter@gmail.com'
           ,@hasKids INT=1
           ,@KidsNumber INT=3
           ,@ChildAges NVARCHAR(2000)='[8,4,3]'
	   ,@CreatedBy INT = 1
	   ,@ModifiedBy INT = 1
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
