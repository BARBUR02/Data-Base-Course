// See https://aka.ms/new-console-template for more information
//Console.WriteLine("Hello, World!");

using JakubBarberEFProducts;
//using System.Linq

/*
Console.WriteLine("Podaj nazwę produktu: ");
string Prodname = Console.ReadLine();
*/


internal class Program
{
    private static void Main(string[] args)
    {
        ProductContext productContext = new ProductContext();
        /*
        Product product1 = new Product { ProductName="kotlet"};
        Product product2 = new Product { ProductName="spaghetti"};
        Product product3 = new Product { ProductName="ziemniaki"};
        Product product4 = new Product { ProductName="ketchup"};
        Supplier supplier = new Supplier
        {
            CompanyName = "Spozywczy PL",
            Street = "Jedzenie 123",
            City = "Torun"
        };
        */

        /*
        Product product1 = new Product { ProductName = "Tyskie" };
        Product product2 = new Product { ProductName = "Zywiec" };
        Product product3 = new Product { ProductName = "Harnas" };
        Product product4 = new Product { ProductName = "Zatecky" };
        Product product5 = new Product { ProductName = "Heineken" };
        Product product6 = new Product { ProductName = "Lech" };
        Supplier supplier = new Supplier
        {
            CompanyName = "Browar PL",
            Street = "Krakowska 123",
            City = "Warszawa"
        };
        product1.Supplier = supplier;
        product2.Supplier = supplier;
        product3.Supplier = supplier;
        product4.Supplier = supplier;
        product5.Supplier = supplier;
        product6.Supplier = supplier;

        productContext.Suppliers.Add(supplier);
        productContext.Suppliers.Add(supplier);
        productContext.Products.Add(product1);
        productContext.Products.Add(product2);
        productContext.Products.Add(product3);
        productContext.Products.Add(product4);
        productContext.Products.Add(product5);
        productContext.Products.Add(product6);


        //Console.WriteLine(supplier);

        //product.Supplier = supplier;
        /*supplier.Products = new HashSet<Product>
        {
            product1,
            product2,
            product3,
            product4
        };
        productContext.Suppliers.Add(supplier);
        productContext.Products.Add(product1);
        productContext.Products.Add(product2);
        productContext.Products.Add(product3);
        productContext.Products.Add(product4);
        Console.WriteLine(supplier.Products.Count);
        */

        //productContext.SaveChanges();
        /*
        Supplier supplier = new Supplier
        {
            CompanyName = "Browar PL",
            Street = "Krakowska 123",
            City = "Warszawa"
        };
        Product product1 = new Product { ProductName = "Tyskie" };
        Product product2 = new Product { ProductName = "Zywiec" };
        Product product3 = new Product { ProductName = "Harnas" };

        product1.Supplier = supplier;
        product2.Supplier = supplier;
        product3.Supplier = supplier;

        supplier.Products.Add(product1);
        supplier.Products.Add(product2);
        supplier.Products.Add(product3);

        Invoice invoice1 = new Invoice { Quantity=10 };
        Invoice invoice2 = new Invoice { Quantity=7 };
        Invoice invoice3 = new Invoice { Quantity=4 };
        invoice1.Products.Add(product1);
        product1.Invoices.Add(invoice1);
        invoice1.Products.Add(product2);
        product2.Invoices.Add(invoice1);
        invoice1.Products.Add(product3);
        product3.Invoices.Add(invoice1);
        invoice2.Products.Add(product1);
        product1.Invoices.Add(invoice2);
        invoice2.Products.Add(product3);
        product3.Invoices.Add(invoice2);
        invoice3.Products.Add(product3);
        product3.Invoices.Add(invoice3);
        productContext.Suppliers.Add(supplier);
        productContext.Products.Add(product1);
        productContext.Products.Add(product2);
        productContext.Products.Add(product3);
        productContext.Invoices.Add(invoice2);
        productContext.Invoices.Add(invoice1);
        productContext.Invoices.Add(invoice3);

        */
        /*
        Supplier supplier1 = new Supplier
        {
            CompanyName = "Sportowy PL",
            Street = "Daliowa 123",
            City = "Poznan"
        };
        Product product4 = new Product { ProductName = "buty sportowe" };
        Product product5 = new Product { ProductName = "narty" };
        product4.Supplier = supplier1;
        product5.Supplier = supplier1;
        supplier1.Products.Add(product4);
        supplier1.Products.Add(product5);


        Invoice invoice4 = new Invoice { Quantity = 10 };
        invoice4.Products.Add(product4);
        invoice4.Products.Add(product5);
        product4.Invoices.Add(invoice4);
        product5.Invoices.Add(invoice4);

        productContext.Suppliers.Add(supplier1);
        productContext.Products.Add(product4);
        productContext.Products.Add(product5);
        productContext.Invoices.Add(invoice4);
        /*
        Product product = new Product { ProductName = "Lech" };
        Invoice invoice = new Invoice { Quantity = 16 };
        product.Invoices.Add(invoice);
        */

        Supplier supplier1 = new Supplier
        {
            CompanyName = "Butik PL",
            Street = "Diamentowa 123",
            City = "Chocholow"
        };
        Supplier supplier2 = new Supplier
        {
            CompanyName = "Remont PL",
            Street = "Betonowa 123",
            City = "Katowice"
        };
        Supplier supplier3 = new Supplier
        {
            CompanyName = "Klub PL",
            Street = "Melanzowa 123",
            City = "Sopot"
        };

        Customer customer1 = new Customer
        {
            CompanyName = "Customer PL",
            Street = "Klientowa 123",
            City = "Sopot"

        };
        Customer customer2 = new Customer
        {
            CompanyName = "Customer PL",
            Street = "Klientowa 123",
            City = "Sopot",
            Discount = 0.2
        };
        Customer customer3 = new Customer
        {
            CompanyName = "Customer PL",
            Street = "Klientowa 123",
            City = "Sopot",
            Discount = 0.3

        };

        productContext.Suppliers.Add(supplier1);
        productContext.Suppliers.Add(supplier2);
        productContext.Suppliers.Add(supplier3);
        productContext.Customers.Add(customer1);
        productContext.Customers.Add(customer2);
        productContext.Customers.Add(customer3);


        productContext.SaveChanges();

        var queryProd = from prod in productContext.Products
                        select prod.ProductName;

        var queryInv = from inv in productContext.Invoices
                       select inv.InvoiceID;

        var querySupp = from comp in productContext.Suppliers
                        select comp.CompanyName;

        var queryCustomers = from cust in productContext.Customers
                        select cust.CompanyName;

        var queryCompanies = from comp in productContext.Companies
                             select comp.CompanyName;

        Console.WriteLine("Ponizej lista dostawcow w naszej bazie : ");
        foreach (var pName in querySupp)
        {
            Console.WriteLine(pName);
        }

        Console.WriteLine("Ponizej lista Klientow w naszej bazie : ");
        foreach (var cName in queryCustomers)
        {
            Console.WriteLine(cName);
        }

        Console.WriteLine("Ponizej lista firm  w naszej bazie : ");
        foreach (var Inum in queryCompanies)
        {
            Console.WriteLine(Inum);
        }
    }
}