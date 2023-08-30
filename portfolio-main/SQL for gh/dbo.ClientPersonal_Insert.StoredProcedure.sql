USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientPersonal_Insert]    Script Date: 8/2/2023 11:24:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Nick Bassirpour
-- Create date: 08/02/2023
-- Description: Insert client personal info the dbo.ClientPersonal table. 
-- Code Reviewer: Lazarus Wright

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:


CREATE PROC [dbo].[ClientPersonal_Insert]
		@ClientId INT,
		@BirthPlaceCountryId INT,
		@BirthPlaceCity NVARCHAR(50),
		@SSN NVARCHAR(20) = NULL,
		@EmployerLocationId INT = NULL,
		@EmployerPhone NVARCHAR(20) = NULL,
		@MailingLocationId INT = NULL,
		@UserId INT,
		@Id INT OUTPUT
		
AS

/*
		
		DECLARE
				@_clientId INT = 9,
				@_birthPlaceCountryId INT = 10,
				@_birthPlaceCity NVARCHAR(50) = 'Cairo',
				@_SSN NVARCHAR(20) = '594-6659-213',
				@_employerLocationId INT = 3,
				@_employerPhone NVARCHAR(20) = '959-662-3261',
				@_mailingLocationId INT = 4,
				@_userId INT = 51,
				@_id INT

		EXEC [dbo].[ClientPersonal_Insert]
				@_clientId,
				@_birthPlaceCountryId,
				@_birthPlaceCity,
				@_SSN,
				@_employerLocationId,
				@_employerPhone,
				@_mailingLocationId,
				@_userId,
				@_id OUTPUT

*/


BEGIN

	INSERT INTO [dbo].[ClientPersonal] 
				(	
				[ClientId],
				[BirthPlaceCountryId],
				[BirthPlaceCity],
				[SSN],
				[EmployerLocationId],
				[EmployerPhone],
				[HomeLocationId],
				[MailingLocationId],
				[CreatedBy],
				[ModifiedBy]
			) VALUES (
				@ClientId,
				@BirthPlaceCountryId,
				@BirthPlaceCity,
				@SSN,
				@EmployerLocationId,
				@EmployerPhone,
				@MailingLocationId,
				@MailingLocationId,
				@UserId,
				@UserId
				)
				
			SET @Id = SCOPE_IDENTITY()

END
GO
