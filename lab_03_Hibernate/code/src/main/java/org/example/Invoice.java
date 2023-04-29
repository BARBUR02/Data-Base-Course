package org.example;

import javax.persistence.*;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Invoice {

    @Id
    @GeneratedValue( strategy = GenerationType.AUTO)
    private int InvoiceNuber;

    private int Quantity;

    public void addProduct(Product product){
        this.products.add(product);
    }

    public Invoice(int quantity) {
        Quantity = quantity;
    }

    public Invoice() {
    }

    public int getInvoiceNuber() {
        return InvoiceNuber;
    }

    public Set<Product> getProducts() {
        return products;
    }

    @ManyToMany(cascade = CascadeType.PERSIST)
    private Set<Product> products= new HashSet<>();

}
