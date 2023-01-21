using CRM.Service.Api.Controllers;
using CRM.Service.Domain.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Moq;
using Xunit;

namespace CRM.Service.UnitTests.Controllers;

public class CustomerControllerTest
{
    [Fact]
    public void GetCustomer_GetAction_MustReturnOkObjectResult()
    {
        CustomerController customerController = new CustomerController();
        var result = customerController.GetCustomer(1);

        var actionResult = Assert.IsType<ActionResult<Customer>>(result);
        var okObjectResult = Assert.IsType<OkObjectResult>(actionResult.Result);
        Customer customer = (Customer) okObjectResult.Value; 
        Assert.Equal(1, customer.CustomerId);
    }
    
}