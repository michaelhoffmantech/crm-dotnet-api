namespace CRM.Service.Domain.ViewModels;

public class Customer
{
    public Customer(int customerId) => CustomerId = customerId;
    
    public int CustomerId { get; set; }
    
}