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

public class Main {
    private static final SessionFactory ourSessionFactory;

    static {
        try {
            Configuration configuration = new Configuration();
            configuration.configure();
            configuration.addAnnotatedClass(Product.class);
            configuration.addAnnotatedClass(Supplier.class);
            configuration.addAnnotatedClass(Category.class);
            configuration.addAnnotatedClass(Invoice.class);

            ourSessionFactory = configuration.buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static Session getSession() throws HibernateException {
        return ourSessionFactory.openSession();
    }

    public static void main(final String[] args) throws Exception {
        final Session session = getSession();
//        Product product1 = new Product("Stolik",112);
//        Product product2 = new Product("Talerz",11);
//        Product product3 = new Product("Widelec",22);
//        Product product4 = new Product("lalka barbie",3);
//        Product product5 = new Product("buzz astral",8);
//        Supplier supplier1 = new Supplier("Chemwit","Golkowicka","Krakow");
//        Supplier supplier2 = new Supplier("Zabawki","Zabawowa","Krakow");
//        Category category1 = new Category("Dom");
//        Category category2 = new Category("Zabawki");
//        Invoice invoice1 = new Invoice(3);
//        Invoice invoice2 = new Invoice(2);
        Invoice invoice = session.get(Invoice.class,10);
//        Product product = session.get(Product.class,1);
//        Category category = session.get(Category.class,8);

        try {
            Transaction tx = session.beginTransaction();
//            product = session.get(Product.class,1);
//            product.setSupplier(supplier);
//            session.save(supplier);
//            session.save(product1);
//            session.save(product2);
//            session.save(product3);
//            category1.addProduct(product1);
//            category1.addProduct(product2);
//            category1.addProduct(product3);
//            category2.addProduct(product4);
//            category2.addProduct(product5);
////            supplier.addToProductsGroup(product1);
////            supplier.addToProductsGroup(product2);
////            supplier.addToProductsGroup(product3);
//            product1.setSupplier(supplier1);
//            product1.addToInvoice(invoice1);
//
//            product2.setSupplier(supplier1);
//            product2.addToInvoice(invoice1);
//
//            product3.setSupplier(supplier1);
//            product3.addToInvoice(invoice1);
//
//            product4.setSupplier(supplier2);
//            product4.addToInvoice(invoice2);
//
//            product5.setSupplier(supplier2);
//            product5.addToInvoice(invoice2);
//
//            session.save(supplier1);
//            session.save(supplier2);
//            session.save(category1);
//            session.save(category2);
//            session.save(invoice1);
//            session.save(invoice2);
            Set<Product> products = invoice.getProducts();
            System.out.println("Numer faktury :"+invoice.getInvoiceNuber());
            for (Product prod : products){
                System.out.println(prod.getProductName());
            }
//            System.out.println("Category of "+product.getProductName());



            tx.commit();
        } finally {
            session.close();
        }
    }
}