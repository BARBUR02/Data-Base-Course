using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JakubBarberEFProducts
{
    
    public class Company
    {
        public int CompanyID { get; set; }
        public String? CompanyName { get; set; }
        public String? Street { get; set; }
        public String? City { get; set; }

        public String? zipCode { get; set; } 
    }
    

    public class Supplier : Company
    {
        public Supplier() { 
            this.Products = new HashSet<Product>();  
        }
        //public int SupplierID { get; set; }
        //public int CompanyID { get; set; }
        //public String? CompanyName { get; set; }
        //public String? Street { get; set; }
        //public String? City { get; set; }
        public long BankAccountNumber { get; set; }

        public ICollection<Product> Products { get; set; }

    }
    
    public class Customer : Company
    {
        //public int CustomerID { get; set; }
        public double Discount { get; set; }
    }
    
}
