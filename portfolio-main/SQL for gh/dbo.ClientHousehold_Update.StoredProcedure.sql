﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousehold_Update]    Script Date: 7/7/2023 9:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousehold_Update]
	    @Id INT 
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
	   ,@ModifiedBy INT
        
as
/*
-- Author: <Harrison Cook>
-- Create date: <06/30/2023>
-- Description: <Updates Client Household by HouseHold Id>
-- Code Reviewer:WENDY RUIZ

	DECLARE @Id INT =22
           ,@ClientId INT=11
           ,@IsMarried BIT=1
           ,@SpouseName NVARCHAR(100)='UPDATED'
           ,@SpouseLastName NVARCHAR(100)='Porter'
           ,@SpouseMi NVARCHAR(2)='L'
           ,@SpouseDob NVARCHAR(20)='06/29/1998'
           ,@SpousePhone NVARCHAR(20)='4249876543'
           ,@SpouseEmail NVARCHAR(255)='michael.porter@gmail.com'
           ,@hasKids INT=1
           ,@KidsNumber INT=3
           ,@ChildAges NVARCHAR(2000)='[8,4,3]'
	   ,@ModifiedBy INT = 1
          
	Execute dbo.ClientHousehold_Update
	    @Id 
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
	   ,@ModifiedBy

*/
BEGIN
	DECLARE @DateModified datetime2 = getutcdate()
	UPDATE [dbo].[ClientHousehold]
          SET [ClientId]=@ClientId 
           ,[IsMarried]=@IsMarried
           ,[SpouseName]=@SpouseName
           ,[SpouseLastName]=@SpouseLastName
           ,[SpouseMi]=@SpouseMi
           ,[SpouseDob]=@SpouseDob
           ,[SpousePhone]=@SpousePhone
           ,[SpouseEmail]=@SpouseEmail
           ,[hasKids]=@hasKids
           ,[KidsNumber]=@KidsNumber
           ,[ChildAges]=@ChildAges
	   ,[ModifiedBy]=@ModifiedBy
	   ,[DateModified]=@DateModified
	WHERE Id=@Id
   
END
GO
