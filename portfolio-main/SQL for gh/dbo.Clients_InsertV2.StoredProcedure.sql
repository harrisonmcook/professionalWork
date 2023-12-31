﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Clients_InsertV2]    Script Date: 7/12/2023 12:27:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Clients_InsertV2]
	   @FirstName NVARCHAR(100)
	   ,@LastName NVARCHAR(100)
	   ,@Mi NVARCHAR(2) = NULL
	   ,@DOB NVARCHAR(20)
	   ,@Phone NVARCHAR(20)
	   ,@Email NVARCHAR(255)
	   ,@LocationId INT
	   ,@HasFamily BIT
	   ,@CreatedBy INT
	   ,@ModifiedBy INT
	   ,@Id INT OUTPUT
	   ,@HouseholdId INT OUTPUT
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
-- Create date: <07/11/2023>
-- Description: <EXECUTES clients_insert and clienthousehold_insert in one proc>
-- Code Reviewer:Nick Bassirpour
		
     Declare 
	    @FirstName NVARCHAR(100)='Bruce'
	   ,@LastName NVARCHAR(100)='Brown'
	   ,@Mi NVARCHAR(2)='J'
	   ,@DOB NVARCHAR(20)='08/15/1996'
	   ,@Phone NVARCHAR(20)=3101234567
	   ,@Email NVARCHAR(255)='bruce.brown@email.com'
	   ,@LocationId INT=15
	   ,@HasFamily bit=1
	   ,@CreatedBy INT=1
	   ,@ModifiedBy INT=1
	   ,@Id INT =0
	   ,@HouseholdId INT =0
           ,@IsMarried BIT=1
           ,@SpouseName NVARCHAR(100)=null
           ,@SpouseLastName NVARCHAR(100)='Porter'
           ,@SpouseMi NVARCHAR(2)='L'
           ,@SpouseDob NVARCHAR(20)='06/29/1998'
           ,@SpousePhone NVARCHAR(20)='4249876543'
           ,@SpouseEmail NVARCHAR(255)='michael.porter@gmail.com'
           ,@hasKids BIT=1
           ,@KidsNumber INT=null
           ,@ChildAges NVARCHAR(2000)='[8,4,3]'

	EXECUTE dbo.Clients_InsertV2
			@FirstName 
			,@LastName 
			,@Mi 
			,@DOB 
			,@Phone
			,@Email 
			,@LocationId
			,@HasFamily 
			,@CreatedBy
			,@ModifiedBy 
			,@Id OUTPUT
			,@HouseholdId OUTPUT
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
 
	EXECUTE dbo.Clients_Insert
			 @FirstName 
			,@LastName 
			,@Mi 
			,@DOB 
			,@Phone
			,@Email 
			,@LocationId
			,@HasFamily 
			,@CreatedBy
			,@ModifiedBy 
			,@Id OUTPUT
		IF @HasFamily=1
			EXECUTE dbo.ClientHousehold_Insert
			 @HouseholdId OUTPUT
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
			,@CreatedBy
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
