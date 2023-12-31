﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[ClientHousehold_Delete]    Script Date: 7/12/2023 12:27:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ClientHousehold_Delete]
	 @Id int
	,@ModifiedBy int
as
/*
-- Author: <Harrison Cook>
-- Create date: <06/30/2023>
-- Description: <"Deletes" Client Household by setting statusId to 1 by Household Id>
-- Code Reviewer:WENDY RUIZ

	Declare @Id int = 22
			,@ModifiedBy int = 1
	Execute dbo.ClientHousehold_Delete
			@Id
			,@ModifiedBy
			
*/
BEGIN
	DECLARE @DateModified datetime2 = getutcdate()
	UPDATE dbo.ClientHousehold
	SET StatusId=5
		,ModifiedBy=@ModifiedBy
		,DateModified=@DateModified
	WHERE Id=@Id
End
GO
