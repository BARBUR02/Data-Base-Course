package org.example;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Product {
    public Product() {}

    public Product(String productName, int unitsOnStock) {
        ProductName = productName;
        UnitsOnStock = unitsOnStock;
    }

    @Id
    @GeneratedValue( strategy = GenerationType.AUTO)
    private int ProductID;

    private String ProductName;
    private int UnitsOnStock;

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
        this.supplier.addToProductsGroup(this);
    }

    public String getProductName() {
        return this.ProductName;
    }

    public Supplier getSupplier() {
        return supplier;
    }
//
    @ManyToOne
    private Supplier supplier ;

    public Set<Invoice> getInvoices() {
        return invoices;
    }

    public void addToInvoice(Invoice invoice){
        this.invoices.add(invoice);
        invoice.addProduct(this);
    }

    @ManyToMany(cascade = CascadeType.PERSIST)
    private Set<Invoice> invoices= new HashSet<>();

}
