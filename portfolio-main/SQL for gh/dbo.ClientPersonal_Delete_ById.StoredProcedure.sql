USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientPersonal_Delete_ById]    Script Date: 8/2/2023 11:24:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Nick Bassirpour
-- Create date: 08/02/2023
-- Description: Delete client personal info from the dbo.ClientPersonal table. 
-- Code Reviewer: Lazarus Wright

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:


CREATE PROC [dbo].[ClientPersonal_Delete_ById]
		@Id INT
		
AS

/*
		
		DECLARE
				@_id INT = 3

		EXEC [dbo].[ClientPersonal_Delete_ById]
				@_id

*/


BEGIN

	UPDATE [dbo].[ClientPersonal] 
				
		SET		[StatusId] = 2
			
		WHERE Id = @Id
			
END
GO
