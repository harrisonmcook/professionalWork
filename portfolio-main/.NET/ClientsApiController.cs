﻿
using Microsoft.AspNetCore.Mvc;

using Microsoft.Extensions.Logging;
using Yellowbrick.Models;
using Yellowbrick.Models.Domain;
using Yellowbrick.Models.Requests.ClientRequests;
using Yellowbrick.Services;
using Yellowbrick.Services.ClientServices;
using Yellowbrick.Web.Controllers;
using Yellowbrick.Web.Models.Responses;
using System;

namespace Yellowbrick.Web.Api.Controllers.ClientControllers
{
    [Route("api/clients")]
    [ApiController]
    public class ClientsApiController : BaseApiController
    {
        private IClientService _service = null;
        private IAuthenticationService<int> _authService = null;
        public ClientsApiController(IClientService service,
            IAuthenticationService<int> authService,
            ILogger<ClientsApiController> logger) : base(logger)
        {
            _authService = authService;
            _service = service;
        }

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<HouseHold>> Get(int id)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                HouseHold houseHold = _service.Get(id);
                if (houseHold == null)
                {
                    code = 404;
                    response = new ErrorResponse("resource not found");
                }
                else
                {
                    response = new ItemResponse<HouseHold> { Item = houseHold };
                }
            }
            catch (Exception ex)
            {
                response = new ErrorResponse(ex.Message);
                code = 500;
                base.Logger.LogError(ex.ToString());
            }
            return StatusCode(code, response);


        }


        [HttpGet("paginate/{userId:int}")]
        public ActionResult<ItemResponse<Paged<Client>>> GetByCreatedId(int pageIndex, int pageSize, int userId)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Client> paged = _service.Get(pageIndex, pageSize, userId);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<Client>> { Item = paged };
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);

            }
            return StatusCode(code, response);
        }

        [HttpGet("byAgent")]
        public ActionResult<ItemResponse<Paged<Client>>> GetByCreatedName(int pageIndex, int pageSize, string agent)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Client> paged = _service.GetByAgentName(pageIndex, pageSize, agent);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<Client>> { Item = paged };
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);

            }
            return StatusCode(code, response);
        }

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<Client>>> GetAll(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Client> paged = _service.GetAll(pageIndex, pageSize);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<Client>> { Item = paged };
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpGet("search")]
        public ActionResult<ItemResponse<Paged<Client>>> Search(int pageIndex, int pageSize, string query)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Client> paged = _service.Search(pageIndex, pageSize, query);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<Client>> { Item = paged };
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpPost]
        public ActionResult<ItemResponse<int>> Add(ClientAddRequest request)
        {
            ObjectResult result = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                int id = _service.Add(request, userId);
                ItemResponse<int> response = new ItemResponse<int>() { Item = id };
                result = Created201(response);
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);
                result = StatusCode(500, response);
            }
            return result;
        }

        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(ClientUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                _service.Update(model, userId);
                if (model == null)
                {
                    code = 404;
                    response = new ErrorResponse("Resource not found");
                }
                else
                {
                    response = new SuccessResponse();
                }
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }
        [HttpDelete("{id:int}")]
        public ActionResult<SuccessResponse> Delete(int id)
        {
            int code = 200;
            BaseResponse response = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                _service.Delete(id, userId);
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);

            }
            return StatusCode(code, response);
        }

        [HttpPost("households")]
        public ActionResult<ItemResponse<int>> AddHousehold(HouseholdAddRequest request)
        {
            ObjectResult result = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                int id = _service.AddHousehold(request, userId);
                ItemResponse<int> response = new ItemResponse<int>() { Item = id };
                result = Created201(response);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);
                result = StatusCode(500, response);
            }
            return result;
        }

        [HttpPut("households/{id:int}")]
        public ActionResult<SuccessResponse> UpdateHousehold(HouseholdUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                _service.UpdateHousehold(model, userId);
                if (model == null)
                {
                    code = 404;
                    response = new ErrorResponse("Resource not found");
                }
                else
                {
                    response = new SuccessResponse();
                }
            }
            catch (Exception ex)
            {
                code = 500;
                Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpDelete("households/{id:int}")]
        public ActionResult<SuccessResponse> DeleteHousehold(int id)
        {
            int code = 200;
            BaseResponse response = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                _service.DeleteHousehold(id, userId);
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);

            }
            return StatusCode(code, response);
        }

        [HttpPost("personals")]
        public ActionResult<ItemResponse<int>> AddPersonalInformation(ClientAddRequest request)
        {
            ObjectResult result = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                int id = _service.AddPersonalInformation(request, userId);
                ItemResponse<int> response = new ItemResponse<int>() { Item = id };
                result = Created201(response);
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);
                result = StatusCode(500, response);
            }
            return result;
        }

        [HttpGet("personals/{id:int}")]
        public ActionResult<ItemResponse<ClientPersonal>> GetPersonalInformation(int id)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                ClientPersonal personal = _service.GetPersonalInformation(id);
                if (personal == null)
                {
                    code = 404;
                    response = new ErrorResponse("resource not found");
                }
                else
                {
                    response = new ItemResponse<ClientPersonal> { Item = personal };
                }
            }
            catch (Exception ex)
            {
                response = new ErrorResponse(ex.Message);
                code = 500;
                base.Logger.LogError(ex.ToString());
            }
            return StatusCode(code, response);


        }

        [HttpPut("personals/{id:int}")]
        public ActionResult<SuccessResponse> UpdatePersonalInformation(ClientPersonalUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;
            int userId = _authService.GetCurrentUserId();
            try
            {
                _service.UpdatePersonalInformation(model, userId);
                if (model == null)
                {
                    code = 404;
                    response = new ErrorResponse("Resource not found");
                }
                else
                {
                    response = new SuccessResponse();
                }
            }
            catch (Exception ex)
            {
                code = 500;
                Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }


    }
}
//
