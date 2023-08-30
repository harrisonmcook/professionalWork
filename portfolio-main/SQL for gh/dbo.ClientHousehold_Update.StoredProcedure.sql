USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousehold_Update]    Script Date: 7/7/2023 9:20:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousehold_Update]
			@Id int 
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
		   ,@ModifiedBy int
        
as
/*
-- Author: <Harrison Cook>
-- Create date: <06/30/2023>
-- Description: <Updates Client Household by HouseHold Id>
-- Code Reviewer:WENDY RUIZ

	DECLARE @Id int =22
           ,@ClientId int=11
           ,@IsMarried bit=1
           ,@SpouseName nvarchar(100)='UPDATED'
           ,@SpouseLastName nvarchar(100)='Porter'
           ,@SpouseMi nvarchar(2)='L'
           ,@SpouseDob nvarchar(20)='06/29/1998'
           ,@SpousePhone nvarchar(20)='4249876543'
           ,@SpouseEmail nvarchar(255)='michael.porter@gmail.com'
           ,@hasKids int=1
           ,@KidsNumber int=3
           ,@ChildAges nvarchar(2000)='[8,4,3]'
		   ,@ModifiedBy int = 1
          
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
