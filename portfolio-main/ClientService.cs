﻿using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.Lookups;
using Sabio.Models.Requests.ClientRequests;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services.ClientServices

{
    public class ClientService : IClientService
    {
        IDataProvider _data = null;
        IMapBaseUser _mapUser = null;
        ILocationMapper _mapLocation = null;
        public ClientService(IDataProvider data, IMapBaseUser mapUser, ILocationMapper mapLocation)
        {
            _data = data;
            _mapUser = mapUser;
            _mapLocation = mapLocation;
        }

        public int Add(ClientAddRequest request, int userId)
        {
            int id = 0;
            _data.ExecuteNonQuery("[dbo].[Clients_Insert]", delegate (SqlParameterCollection col)
            {
                AddCommonParams(request, col);
                col.AddWithValue("@CreatedBy", userId);
                col.AddWithValue("@ModifiedBy", userId);
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                col.Add(idOut);

            }, delegate (SqlParameterCollection returncol)
            {
                object oId = returncol["@Id"].Value;
                int.TryParse(oId.ToString(), out id);
            });
            return id;

        }
        public int AddPersonalInformation(ClientAddRequest request, int userId)
        {
            int id = 0;
            int householdId = 0;
            _data.ExecuteNonQuery("[dbo].[Clients_InsertV2]", delegate (SqlParameterCollection col)
            {
                string ages = JsonConvert.SerializeObject(request.ChildAges);
                AddCommonParams(request, col);
                AddCommonHouseholdParams(request, col);
                col.AddWithValue("@CreatedBy", userId);
                col.AddWithValue("@ModifiedBy", userId);
                col.AddWithValue("@ChildAges", ages);
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                col.Add(idOut);
                SqlParameter householdIdOut = new SqlParameter("@HouseholdId", SqlDbType.Int);
                householdIdOut.Direction = ParameterDirection.Output;
                col.Add(householdIdOut);
            }, delegate (SqlParameterCollection returncol)
            {
                object householdIdOut = returncol["@HouseholdId"].Value;
                int.TryParse(householdIdOut.ToString(), out householdId);
                object oId = returncol["@Id"].Value;
                int.TryParse(oId.ToString(), out id);
            });
            return id;

        }
        public HouseHold Get(int id)
        {

            HouseHold houseHold = null;
            _data.ExecuteCmd("[dbo].[Clients_SelectPersonalById]", delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", id);
            }, delegate (IDataReader reader, short set)
            {
                int idx = 0;
                houseHold = MapSingleHousehold(reader, ref idx);

            });
            return houseHold;

        }
        public ClientPersonal GetPersonalInformation(int id)
        {
            ClientPersonal personal = null;
            _data.ExecuteCmd("[dbo].[Clients_SelectPersonalByIdV2]", delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", id);
            }, delegate (IDataReader reader, short set)
            {
                int idx = 0;
                personal = MapSingleClientPesonal(reader, ref idx);

            });
            return personal;
        }
        public Paged<Client> Get(int pageIndex, int pageSize, int CreatedId)
        {
            Paged<Client> pagedList = null;
            List<Client> list = null;
            int totalCount = 0;
            _data.ExecuteCmd("[dbo].[Clients_Select_ByCreatedBy]", delegate (SqlParameterCollection col)
            {

                col.AddWithValue("@PageIndex", pageIndex);
                col.AddWithValue("@PageSize", pageSize);
                col.AddWithValue("@UserId", CreatedId);
            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                Client client = MapSingleClient(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex++);
                if (list == null)
                { list = new List<Client>(); }
                list.Add(client);

            });
            if (list != null)
            {
                pagedList = new Paged<Client>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }
        public Paged<Client> GetByAgentName(int pageIndex, int pageSize, string agent)
        {
            Paged<Client> pagedList = null;
            List<Client> list = null;
            int totalCount = 0;
            _data.ExecuteCmd("[dbo].[Clients_Select_ByCreatedBy_Name]", delegate (SqlParameterCollection col)
            {

                col.AddWithValue("@PageIndex", pageIndex);
                col.AddWithValue("@PageSize", pageSize);
                col.AddWithValue("@Agent", agent);
            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                Client client = MapSingleClient(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex++);
                if (list == null)
                { list = new List<Client>(); }
                list.Add(client);

            });
            if (list != null)
            {
                pagedList = new Paged<Client>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }
        public Paged<Client> GetAll(int pageIndex, int pageSize)
        {
            Paged<Client> pagedList = null;
            List<Client> list = null;
            int totalCount = 0;
            _data.ExecuteCmd("[dbo].[Clients_SelectAll]", delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@PageIndex", pageIndex);
                col.AddWithValue("@PageSize", pageSize);
            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                Client client = MapSingleClient(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex++);
                if (list == null)
                { list = new List<Client>(); }
                list.Add(client);

            });
            if (list != null)
            {
                pagedList = new Paged<Client>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }
        public Paged<Client> Search(int pageIndex, int pageSize, string query)
        {
            Paged<Client> pagedList = null;
            List<Client> list = null;
            int totalCount = 0;
            _data.ExecuteCmd("[dbo].[Clients_Search]", delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@PageIndex", pageIndex);
                col.AddWithValue("@PageSize", pageSize);
                col.AddWithValue("@Query", query);
            }, delegate (IDataReader reader, short set)
            {
                int startingIndex = 0;
                Client client = MapSingleClient(reader, ref startingIndex);
                totalCount = reader.GetSafeInt32(startingIndex++);
                if (list == null)
                { list = new List<Client>(); }
                list.Add(client);

            });
            if (list != null)
            {
                pagedList = new Paged<Client>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }
        public void Update(ClientUpdateRequest request, int userId)
        {
            _data.ExecuteNonQuery("[dbo].[Clients_Update]", delegate (SqlParameterCollection col)
            {
                AddCommonParams(request, col);
                col.AddWithValue("@Id", request.Id);
                col.AddWithValue("@ModifiedBy", userId);

            });

        }
        public void UpdatePersonalInformation(ClientPersonalUpdateRequest request, int userId)
        {
            string ages = JsonConvert.SerializeObject(request.ChildAges);
            _data.ExecuteNonQuery("[dbo].[Clients_UpdateV2]", delegate (SqlParameterCollection col)
            {
                AddCommonParams(request, col);
                AddCommonHouseholdParams(request, col);
                col.AddWithValue("@Id", request.Id);
                col.AddWithValue("@ModifiedBy", userId);
                col.AddWithValue("@ChildAges", ages);

            });
        }
        public void Delete(int id, int userId)
        {
            _data.ExecuteNonQuery("dbo.Clients_Delete", delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", id);
                col.AddWithValue("@ModifiedBy", userId);
            });
        }
        public int AddHousehold(HouseholdAddRequest request, int userId)
        {
            string ages = JsonConvert.SerializeObject(request.ChildAges);
            int Id = 0;
            _data.ExecuteNonQuery("[dbo].[ClientHousehold_Insert]", delegate (SqlParameterCollection col)
            {   
                AddCommonHouseholdParams(request, col);
                col.AddWithValue("@ChildAges", ages);
                col.AddWithValue("@CreatedBy", userId);
                col.AddWithValue("@ModifiedBy", userId);
                col.AddWithValue("@ClientId", request.ClientId);
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                col.Add(idOut);

            }, delegate (SqlParameterCollection returncol)
            {
                object oId = returncol["@Id"].Value;
                int.TryParse(oId.ToString(), out Id);
            });
            return Id;
        }
        public void UpdateHousehold(HouseholdUpdateRequest request, int userId)
        {
            string ages = JsonConvert.SerializeObject(request.ChildAges);
            _data.ExecuteNonQuery("[dbo].[ClientHousehold_Update]", delegate (SqlParameterCollection col)
            {
                AddCommonHouseholdParams(request, col);
                col.AddWithValue("@Id", request.Id);
                col.AddWithValue("@ChildAges", ages);
                col.AddWithValue("@ModifiedBy", userId);
            });
        }
        public void DeleteHousehold(int id, int userId)
        {
            _data.ExecuteNonQuery("[dbo].[ClientHousehold_Delete]", delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", id);
                col.AddWithValue("@ModifiedBy", userId);
            });
        }
        private static void AddCommonHouseholdParams(HouseholdAddRequest request, SqlParameterCollection col)
        {
            
            col.AddWithValue("@IsMarried", request.IsMarried);
            col.AddWithValue("@SpouseName", request.SpouseName);
            col.AddWithValue("@SpouseLastName", request.SpouseLastName);
            col.AddWithValue("@SpouseMi", request.SpouseMi);
            col.AddWithValue("@SpouseDob", request.SpouseDob);
            col.AddWithValue("@SpousePhone", request.SpousePhone);
            col.AddWithValue("@SpouseEmail", request.SpouseEmail);
            col.AddWithValue("@hasKids", request.HasKids);
            col.AddWithValue("@KidsNumber", request.KidsNumber);

        }

        private Client MapSingleClient(IDataReader reader, ref int startingIndex)
        {

            Client client = new Client();
            client.Id = reader.GetSafeInt32(startingIndex++);
            client.FirstName = reader.GetSafeString(startingIndex++);
            client.LastName = reader.GetSafeString(startingIndex++);
            client.Mi = reader.GetSafeString(startingIndex++);
            client.DOB = reader.GetSafeString(startingIndex++);
            client.Phone = reader.GetSafeString(startingIndex++);
            client.Email = reader.GetSafeString(startingIndex++);
            client.Location = _mapLocation.MapSingleLocation(reader,ref startingIndex);
            client.HasFamily = reader.GetSafeBool(startingIndex++);
            client.Status = reader.DeserializeObject<LookUp>(startingIndex++);
            client.CreatedBy = _mapUser.MapBaseUser(reader, ref startingIndex);
            client.ModifiedBy = reader.GetSafeInt32(startingIndex++);
            client.DateCreated = reader.GetSafeUtcDateTime(startingIndex++);
            client.DateModified = reader.GetSafeUtcDateTime(startingIndex++);

            return client;
        }
   
        private static void AddCommonParams(ClientAddRequest request, SqlParameterCollection col)
        {
            col.AddWithValue("@FirstName", request.FirstName);
            col.AddWithValue("@LastName", request.LastName);
            col.AddWithValue("@Mi", request.Mi);
            col.AddWithValue("@DOB", request.DOB);
            col.AddWithValue("@Phone", request.Phone);
            col.AddWithValue("@Email", request.Email);
            col.AddWithValue("@LocationId", request.LocationId);
            col.AddWithValue("@HasFamily", request.HasFamily);
            
        }
        private HouseHold MapSingleHousehold(IDataReader reader, ref int idx)
        {
            HouseHold houseHold = new HouseHold();
            if (idx == 0)
            {
                houseHold.Client = MapSingleClient(reader, ref idx);
            }
            houseHold.Id = reader.GetSafeInt32(idx++);
            houseHold.IsMarried = reader.GetSafeBool(idx++);
            houseHold.SpouseName = reader.GetSafeString(idx++);
            houseHold.SpouseLastName = reader.GetSafeString(idx++);
            houseHold.SpouseMi = reader.GetSafeString(idx++);
            houseHold.SpouseDob = reader.GetSafeString(idx++);
            houseHold.SpousePhone = reader.GetSafeString(idx++);
            houseHold.SpouseEmail = reader.GetSafeString(idx++);
            houseHold.HasKids = reader.GetSafeBool(idx++);
            houseHold.KidsNumber = reader.GetSafeInt32(idx++);
            houseHold.ChildAges = reader.DeserializeObject<List<int>>(idx++);
            houseHold.Status = reader.DeserializeObject<LookUp>(idx++);
            houseHold.CreatedBy = _mapUser.MapBaseUser(reader, ref idx);
            houseHold.ModifiedBy = reader.GetSafeInt32(idx++);
            houseHold.DateCreated = reader.GetSafeDateTime(idx++);
            houseHold.DateModified = reader.GetSafeDateTime(idx++);


            return houseHold;
        }
        private ClientPersonal MapSingleClientPesonal(IDataReader reader, ref int idx)
        {
            ClientPersonal clientPersonal = new ClientPersonal();
            clientPersonal.Id = reader.GetSafeInt32(idx++);
            clientPersonal.FirstName = reader.GetSafeString(idx++);
            clientPersonal.LastName = reader.GetSafeString(idx++);
            clientPersonal.Mi = reader.GetSafeString(idx++);
            clientPersonal.DOB = reader.GetSafeString(idx++);
            clientPersonal.Phone = reader.GetSafeString(idx++);
            clientPersonal.Email = reader.GetSafeString(idx++);
            clientPersonal.Location = _mapLocation.MapSingleLocation(reader, ref idx);
            clientPersonal.HasFamily = reader.GetSafeBool(idx++);
            clientPersonal.Status = reader.DeserializeObject<LookUp>(idx++);
            clientPersonal.CreatedBy = _mapUser.MapBaseUser(reader, ref idx);
            clientPersonal.ModifiedBy = reader.GetSafeInt32(idx++);
            clientPersonal.DateCreated = reader.GetSafeUtcDateTime(idx++);
            clientPersonal.DateModified = reader.GetSafeUtcDateTime(idx++);
            if (clientPersonal.HasFamily == true)
            { 
             
                clientPersonal.Household = MapSingleHousehold(reader, ref idx); }
            return clientPersonal;
        }
        public ClientBase MapClientBase(IDataReader reader, ref int startingIndex)
        {
            ClientBase client = new ClientBase();

            client.Id = reader.GetSafeInt32(startingIndex++);
            client.FirstName = reader.GetSafeString(startingIndex++);
            client.LastName = reader.GetSafeString(startingIndex++);
            client.Mi = reader.GetSafeString(startingIndex++);

            return client;
        }
       


    }
}
