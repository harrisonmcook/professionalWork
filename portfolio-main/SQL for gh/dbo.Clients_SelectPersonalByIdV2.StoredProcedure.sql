﻿USE [YellowBrick]
GO
/****** Object:  StoredProcedure [dbo].[Clients_SelectPersonalByIdV2]    Script Date: 7/12/2023 12:27:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Clients_SelectPersonalByIdV2]
		@Id INT

as
/*
-- Author: <Harrison Cook>
-- Create date: <07/11/2023>
-- Description: <Select all Columns of Client joined with Location joined with household by Client Id>
-- Code Reviewer:
		Declare @Id INT = 99
		Execute dbo.Clients_SelectPersonalByIdV2
			@Id
				
*/
BEGIN 
DECLARE @HasFamily bit = 0
SELECT  @HasFamily  =  HasFamily 
        from dbo.Clients
        where id = @Id
IF      @HasFamily=0

SELECT  cl.Id
       ,cl.[FirstName]
       ,cl.[LastName]
       ,cl.[Mi]
       ,[DOB]
       ,[Phone]
       ,cl.[Email]
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
       ,Status=(Select s.id,s.Name from dbo.StatusTypes as s
				inner join dbo.Clients as c
				on c.StatusId=s.Id
				where c.id = cl.id
				for JSON AUTO, without_array_wrapper)
       ,u.id
       ,u.FirstName
       ,u.LastName
       ,u.Mi
       ,u.AvatarUrl
       ,cl.ModifiedBy
       ,cl.DateCreated
       ,cl.DateModified
       from dbo.Clients as cl
       inner join dbo.Locations as l
       on l.Id=cl.LocationId
       inner join dbo.LocationTypes as t
       on t.id=l.LocationTypeId
       inner join dbo.States as st
       on st.Id=l.StateId
       inner join dbo.Users as u
       on u.id=cl.CreatedBy
       where @Id=cl.Id
	
ELSE
SELECT		
       co.Id
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
      ,Status=(Select s.id,s.Name from dbo.StatusTypes as s
				inner join dbo.Clients as c
				on c.StatusId=s.Id
				where c.id = co.id
				for JSON AUTO, without_array_wrapper)
      ,u.id
      ,u.FirstName
      ,u.LastName
      ,u.Mi
      ,u.AvatarUrl
      ,co.ModifiedBy
      ,co.DateCreated
      ,co.DateModified
      ,ch.Id as 'HouseholdId'
      ,[IsMarried]
      ,[SpouseName]
      ,[SpouseLastName]
      ,[SpouseMi]
      ,[SpouseDob]
      ,[SpousePhone]
      ,[SpouseEmail]
      ,[hasKids]
      ,[KidsNumber]
      ,[ChildAges]
      ,Status=( Select s.Name from dbo.StatusTypes as s
		inner join dbo.ClientHousehold as chd
		on chd.StatusId=s.Id
		where chd.id=ch.Id
		for JSON AUTO, without_array_wrapper)
				
       ,uh.id
       ,uh.FirstName
       ,uh.LastName
       ,uh.Mi
       ,uh.AvatarUrl
       ,ch.ModifiedBy
       ,ch.DateCreated
       ,ch.DateModified
	FROM [dbo].[ClientHousehold] as ch
	inner join dbo.Clients as co
	on ch.ClientId=co.Id
	inner join dbo.Locations as L
		on co.LocationId=l.Id
		inner join dbo.States as st on st.Id = l.Id 
		inner join dbo.LocationTypes as t on l.LocationTypeId = t.Id
	inner join dbo.StatusTypes as s
	on co.StatusId=s.Id
	inner join dbo.Users as u 
	on u.Id=co.CreatedBy
	inner join dbo.Users as uh
	on uh.Id=ch.CreatedBy
	Where @Id = ch.ClientId
		
	
END



GO
