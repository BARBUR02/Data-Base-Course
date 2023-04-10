using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JakubBarberEFProducts
{
    public class Product
    {
        public Product() { 
            this.Invoices = new HashSet<Invoice>();
        }    
        public int ProductID { get; set; }
        public string? ProductName { get; set; }
        public int UnitsOnStock { get; set; }

        //public Supplier? Supplier { get; set; }
        public Supplier? Supplier { get; set; }
        public ICollection<Invoice> Invoices { get; set; }
    }
}
