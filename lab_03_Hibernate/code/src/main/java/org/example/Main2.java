package org.example;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import java.util.List;
import java.util.Set;

public class Main2 {

    public static void main(final String[] args) throws Exception {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("myDatabaseConfig");
        EntityManager em = emf.createEntityManager();
        EntityTransaction etx = em.getTransaction();
        etx.begin();
//        Category category = new Category("Ubrania");
//        Product product2 = new Product("szczotka",10);
//        Product product3 = new Product("miotla",5);
//        Supplier supplier = em.find(Supplier.class,13);
//        Product product = new Product("gucci flipflops",2);
        Supplier supplier = new Supplier("CompanyOneTab",  "bogolska", "Krakow", "30-355","444 444 444");
        Customer customer = new Customer("CustomerOneTab",  "bogolska", "Krakow", "30-355",0.4);
//        Invoice invoice = new Invoice(1);
//        Category category = new Category("Sprzatanie");
//        product1.setSupplier(supplier);
//        product2.setSupplier(supplier);
//        product3.setSupplier(supplier);
//        product.setSupplier(supplier);
//        category.addProduct(product1);
//        category.addProduct(product2);
//        category.addProduct(product3);
//        category.addProduct(product);
//        product1.addToInvoice(invoice);
//        product2.addToInvoice(invoice);
//        product3.addToInvoice(invoice);
//        product.addToInvoice(invoice);
//        em.persist(product);
//        em.persist(supplier);
//        em.persist(category);
        em.persist(supplier);
        em.persist(customer);
//        em.persist(category);
//        em.persist(invoice);
//        Product product1 = em.find(Product.class,2);
//        System.out.println(product1.getProductName());

//        Set<Product> products = invoice1.getProducts();
//        System.out.println("Numer faktury :"+invoice.getInvoiceNuber());
//        for (Product prod : products){
//            System.out.println(prod.getProductName());
//        }


        etx.commit();
        em.close();

    }
}