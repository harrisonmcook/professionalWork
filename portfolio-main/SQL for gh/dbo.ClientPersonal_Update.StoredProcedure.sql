USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientPersonal_Update]    Script Date: 8/2/2023 11:24:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Nick Bassirpour
-- Create date: 08/02/2023
-- Description: Update client personal info the dbo.ClientPersonal table. 
-- Code Reviewer: Lazarus Wright

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:


CREATE PROC [dbo].[ClientPersonal_Update]
		@Id INT,
		@ClientId INT,
		@BirthPlaceCountryId INT,
		@BirthPlaceCity NVARCHAR(50),
		@SSN NVARCHAR(20) = NULL,
		@EmployerLocationId INT = NULL,
		@EmployerPhone NVARCHAR(20) = NULL,
		@MailingLocationId INT = NULL,
		@UserId INT
		
AS

/*
		
		DECLARE
				@_id INT = 3,
				@_clientId INT = 9,
				@_birthPlaceCountryId INT = 11,
				@_birthPlaceCity NVARCHAR(50) = 'Glendale',
				@_SSN NVARCHAR(20) = '594-6659-033',
				@_employerLocationId INT = 3,
				@_employerPhone NVARCHAR(20) = '959-662-3261',
				@_mailingLocationId INT = 4,
				@_modifiedBy INT = 48

		EXEC [dbo].[ClientPersonal_Update]
				@_id,
				@_clientId,
				@_birthPlaceCountryId,
				@_birthPlaceCity,
				@_SSN,
				@_employerLocationId,
				@_employerPhone,
				@_mailingLocationId,
				@_modifiedBy

*/


BEGIN

	UPDATE [dbo].[ClientPersonal] 
				
		SET		[ClientId] = @ClientId,
				[BirthPlaceCountryId] = @BirthPlaceCountryId,
				[BirthPlaceCity] = @BirthPlaceCity,
				[SSN] = @SSN,
				[EmployerLocationId] = @EmployerLocationId,
				[EmployerPhone] = @EmployerPhone,
				[HomeLocationId] = @MailingLocationId,
				[MailingLocationId] = @MailingLocationId,
				[ModifiedBy] = @UserId,
				[DateModified] = GETUTCDATE()
			
		WHERE Id = @Id
			
END
GO
