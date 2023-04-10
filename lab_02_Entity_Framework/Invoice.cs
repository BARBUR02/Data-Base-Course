using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JakubBarberEFProducts
{
    public class Invoice
    {
        public Invoice() {
            this.Products = new HashSet<Product>();
        }
        public int InvoiceID { get; set; }  
        public int Quantity { get; set; }

        public ICollection<Product> Products { get; set; }
    }
}
