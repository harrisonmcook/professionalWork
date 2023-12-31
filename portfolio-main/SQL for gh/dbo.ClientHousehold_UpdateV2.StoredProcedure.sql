﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousehold_UpdateV2]    Script Date: 7/26/2023 9:40:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousehold_UpdateV2]
			 
            @ClientId INT
           ,@IsMarried BIT
           ,@SpouseName NVARCHAR(100)=Null
           ,@SpouseLastName NVARCHAR(100)=Null
           ,@SpouseMi NVARCHAR(2)=Null
           ,@SpouseDob NVARCHAR(20)=Null
           ,@SpousePhone NVARCHAR(20)=Null
           ,@SpouseEmail NVARCHAR(255)=Null
           ,@hasKids BIT
           ,@KidsNumber INT=Null
           ,@ChildAges NVARCHAR(2000)=Null
	   ,@ModifiedBy INT
        
as
/*
-- Author: <Harrison Cook>
-- Create date: <07/20/2023>
-- Description: <Updates Client Household by client Id>
-- Code Reviewer:

	DECLARE
            @ClientId INT=236
           ,@IsMarried BIT=1
           ,@SpouseName NVARCHAR(100)='UPDATED'
           ,@SpouseLastName NVARCHAR(100)='Porter'
           ,@SpouseMi NVARCHAR(2)='L'
           ,@SpouseDob NVARCHAR(20)='06/29/1998'
           ,@SpousePhone NVARCHAR(20)='424-987-6543'
           ,@SpouseEmail NVARCHAR(255)='michael.porter@gmail.com'
           ,@hasKids bit=1
           ,@KidsNumber INT=3
           ,@ChildAges NVARCHAR(2000)='[8,4,3]'
	   ,@ModifiedBy INT = 1
          
	Execute dbo.ClientHousehold_UpdateV2
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
	   ,@ModifiedBy

*/
BEGIN
	DECLARE @DateModified datetime2 = getutcdate()
	UPDATE [dbo].[ClientHousehold]
          SET 
            [IsMarried]=@IsMarried
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
	WHERE ClientId=@ClientId
   
END
GO
