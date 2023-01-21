using CRM.Service.Domain.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace CRM.Service.Api.Controllers;

[ApiController]
[Route("customer")]
public class CustomerController : ControllerBase
{
    
    [HttpGet("{id}")]
    public ActionResult<Customer> GetCustomer(int id)
    {
        return Ok(new Customer(id)); 
    }
}