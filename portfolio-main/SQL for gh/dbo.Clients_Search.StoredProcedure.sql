﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Clients_Search]    Script Date: 8/9/2023 11:30:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Clients_Search]
	 @Query NVARCHAR(100)
        ,@PageIndex INT 
	,@PageSize INT
as
/*
-- Author: <Harrison Cook>
-- Create date: <06/30/2023>
-- Description: <Select a paginated view of all rows in dbo.Clients joined with location that match lastname query>
-- Code Reviewer:Wendy Ruiz

DECLARE @Query nvarchar(100) = 'Muscala'
       ,@PageIndex INT = 0
       ,@PageSize INT = 1000
EXECUTE [dbo].[Clients_Search]
	@Query
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
	inner join dbo.States as st on st.Id = l.StateId
	inner join dbo.LocationTypes as t on l.LocationTypeId = t.Id
	inner join dbo.Users as u
	on u.Id=co.CreatedBy
	where (
        co.LastName LIKE '%' + @Query + '%'
        OR co.FirstName LIKE '%' + @Query + '%'
    )
    OR (
        co.LastName + ' ' + co.FirstName LIKE '%' + @Query + '%'
    )
    OR (
        co.FirstName + ' ' + co.LastName LIKE '%' + @Query + '%'
    )
    OR (
        co.FirstName + ' ' + co.Mi + ' ' + co.LastName LIKE '%' + @Query + '%'
    )
    OR (
        co.FirstName + ' ' + co.LastName + ' ' + co.Mi LIKE '%' + @Query + '%'
    )
    OR (
        co.LastName + ' ' + co.Mi + ' ' + co.FirstName LIKE '%' + @Query + '%'
    )
    OR (
        co.LastName + ' ' + co.Mi + ' ' + co.FirstName + ' ' + co.LastName LIKE '%' + @Query + '%'
    )
	and co.StatusId=1
	Order By co.Id
	OFFSET @offSet Rows
    Fetch Next @PageSize Rows ONLY
		
END


GO
