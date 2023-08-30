USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousehold_UpdateV2]    Script Date: 7/26/2023 9:40:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousehold_UpdateV2]
			 
            @ClientId int
           ,@IsMarried bit
           ,@SpouseName nvarchar(100)=Null
           ,@SpouseLastName nvarchar(100)=Null
           ,@SpouseMi nvarchar(2)=Null
           ,@SpouseDob nvarchar(20)=Null
           ,@SpousePhone nvarchar(20)=Null
           ,@SpouseEmail nvarchar(255)=Null
           ,@hasKids bit
           ,@KidsNumber int=Null
           ,@ChildAges nvarchar(2000)=Null
		   ,@ModifiedBy int
        
as
/*
-- Author: <Harrison Cook>
-- Create date: <07/20/2023>
-- Description: <Updates Client Household by client Id>
-- Code Reviewer:

	DECLARE
            @ClientId int=236
           ,@IsMarried bit=1
           ,@SpouseName nvarchar(100)='UPDATED'
           ,@SpouseLastName nvarchar(100)='Porter'
           ,@SpouseMi nvarchar(2)='L'
           ,@SpouseDob nvarchar(20)='06/29/1998'
           ,@SpousePhone nvarchar(20)='424-987-6543'
           ,@SpouseEmail nvarchar(255)='michael.porter@gmail.com'
           ,@hasKids bit=1
           ,@KidsNumber int=3
           ,@ChildAges nvarchar(2000)='[8,4,3]'
		   ,@ModifiedBy int = 1
          
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
