﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Clients_Select_ByCreatedBy]    Script Date: 7/12/2023 12:27:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Clients_Select_ByCreatedBy]
	 @UserId INT
	,@PageIndex INT 
	,@PageSize INT
as
/*
-- Author: <Harrison Cook>
-- Create date: <06/30/2023>
-- Description: <Select all Columns of Client joined with Location joined with User by CreatedBy>
-- Code Reviewer:Wendy Ruiz

DECLARE  @UserId INT = 1
	,@PageIndex INT = 0
	,@PageSize INT = 5
EXECUTE [dbo].[Clients_Select_ByCreatedBy]
	 @UserId
	,@PageIndex
	,@PageSize
*/
BEGIN
Declare @offset int = @PageIndex * @PageSize
SELECT co.Id
      ,co.[FirstName]
      ,co.[LastName]
      ,co.[Mi]
      ,[DOB]
      ,[Phone]
      ,co.[Email]
      ,l.[Id]
      ,l.[LocationTypeId]
      ,t.[Name]
      ,l.[LineOne]
      ,l.[LineTwo]
      ,l.[City]
      ,l.[Zip]
      ,l.[StateId]
      ,st.[Name]
      ,st.[Code]
      ,l.[Latitude]
      ,l.[Longitude]
      ,[HasFamily]
      ,Status=(Select s.id, s.Name from dbo.StatusTypes as s
				inner join dbo.Clients as c
				on c.StatusId=s.Id
				where c.id = co.id
				for JSON AUTO, without_array_wrapper
				)
      ,u.id
      ,u.FirstName
      ,u.LastName
      ,u.Mi
      ,u.AvatarUrl
      ,co.[ModifiedBy]
      ,co.[DateCreated]
      ,co.[DateModified]
      ,TotalCount = COUNT(1) OVER() 
	FROM dbo.Clients as co
	inner join dbo.Locations as L
	on co.LocationId=l.Id
	inner join dbo.States as st on st.Id = l.Id 
	inner join dbo.LocationTypes as t on l.LocationTypeId = t.Id
	inner join dbo.Users as u
	on u.Id=co.CreatedBy
	Where co.CreatedBy=@UserId
	and co.StatusId=1
	Order By co.Id
	OFFSET @offSet Rows
    Fetch Next @PageSize Rows ONLY
	

END


GO
