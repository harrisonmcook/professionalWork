﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Clients_UpdateV2]    Script Date: 7/26/2023 9:40:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE proc [dbo].[Clients_UpdateV2]
		        @FirstName NVARCHAR(100)
		       ,@LastName NVARCHAR(100)
		       ,@Mi NVARCHAR(2) = NULL
		       ,@DOB NVARCHAR(20)
		       ,@Phone NVARCHAR(20)
		       ,@Email NVARCHAR(255)
		       ,@LocationId INT
		       ,@HasFamily BIT
		       ,@ModifiedBy INT
		       ,@Id INT 
		       ,@IsMarried BIT
		       ,@SpouseName NVARCHAR(100) = NULL
		       ,@SpouseLastName NVARCHAR(100) = NULL
		       ,@SpouseMi NVARCHAR(2) = NULL
		       ,@SpouseDob NVARCHAR(20) = NULL
		       ,@SpousePhone NVARCHAR(20) = NULL
		       ,@SpouseEmail NVARCHAR(255) = NULL
		       ,@hasKids BIT
		       ,@KidsNumber INT = NULL
		       ,@ChildAges NVARCHAR(2000) = NULL
		  
as
/*
-- Author: <Harrison Cook>
-- Create date: <07/20/2023>
-- Description: <EXECUTES clients_update and clienthousehold_update in one proc>
-- Code Reviewer
		
	Declare 	@FirstName NVARCHAR(100)='randy'
		       ,@LastName NVARCHAR(100)='moss'
		       ,@Mi NVARCHAR(2)='J'
		       ,@DOB NVARCHAR(20)='08/15/1996'
		       ,@Phone NVARCHAR(20)=3101234567
		       ,@Email NVARCHAR(255)='jasonG@email.com'
		       ,@LocationId INT=11
		       ,@HasFamily BIT=1
		       ,@ModifiedBy INT=1
		       ,@Id INT =220
		       ,@IsMarried BIT=1
		       ,@SpouseName NVARCHAR(100)='chris'
		       ,@SpouseLastName NVARCHAR(100)='gonzales'
		       ,@SpouseMi NVARCHAR(2)='L'
		       ,@SpouseDob NVARCHAR(20)='06/29/1998'
		       ,@SpousePhone NVARCHAR(20)='4249876543'
		       ,@SpouseEmail NVARCHAR(255)='emily.porter@gmail.com'
		       ,@hasKids BIT=0
		       ,@KidsNumber INT=1
		       ,@ChildAges NVARCHAR(2000)=null

	EXECUTE dbo.Clients_UpdateV2
			 @FirstName 
			,@LastName 
			,@Mi 
			,@DOB 
			,@Phone
			,@Email 
			,@LocationId
			,@HasFamily 
			,@ModifiedBy 
			,@Id 
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
	SELECT * from dbo.Clients as c
			full outer join dbo.ClientHousehold as ch
			on ch.ClientId=@Id
			where c.Id=@Id
*/
BEGIN TRY
 
	BEGIN TRANSACTION
 
	EXECUTE dbo.Clients_Update
			 @FirstName 
			,@LastName 
			,@Mi 
			,@DOB 
			,@Phone
			,@Email 
			,@LocationId
			,@HasFamily 
			,@ModifiedBy 
			,@Id 

			EXECUTE dbo.ClientHousehold_UpdateV2
			 @Id 
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
	COMMIT TRANSACTION;
	
END TRY
 
BEGIN CATCH
			
			IF @@TRANCOUNT > 0 ROLLBACK
				DECLARE @MSG NVARCHAR(2048) = ERROR_MESSAGE()
				RAISERROR (@MSG,16,1)
			ROLLBACK;
 
END CATCH
GO
