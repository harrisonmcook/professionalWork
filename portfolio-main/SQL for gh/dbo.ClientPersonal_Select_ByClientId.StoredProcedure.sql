USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientPersonal_Select_ByClientId]    Script Date: 8/2/2023 11:24:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Nick Bassirpour
-- Create date: 08/02/2023
-- Description: Select client personal info from the dbo.ClientPersonal table. 
-- Code Reviewer: Lazarus Wright

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:


CREATE PROC [dbo].[ClientPersonal_Select_ByClientId]
		@ClientId INT
		
AS

/*
		
		DECLARE
				@_clientId INT = 7

		EXEC [dbo].[ClientPersonal_Select_ByClientId]
				@_clientId

*/


BEGIN

		SELECT 
				c.FirstName,
				c.Mi,
				c.LastName,
				c.DOB,
				c.Email,
				ce.Employer,
				ce.YearsEmployed,
				ce.ClientOccupation,
				[BirthPlaceCountry] = 
						(
						SELECT [Name] 
						FROM
							[dbo].[Countries] AS co
						INNER JOIN	
							[dbo].[ClientPersonal] AS cp
						ON
							co.Id = cp.BirthPlaceCountryId
						WHERE	
							cp.ClientId = @ClientId
						),
				cp.SSN,
				cp.EmployerPhone
	
		FROM 
				[dbo].[Clients] AS c
		INNER JOIN
				[dbo].[ClientPersonal] AS cp
		ON
				cp.ClientId = c.Id
		INNER JOIN
				[dbo].[ClientEmployment] AS ce
		ON
				ce.ClientId = c.Id
		WHERE 
				c.Id = @ClientId

END
GO
