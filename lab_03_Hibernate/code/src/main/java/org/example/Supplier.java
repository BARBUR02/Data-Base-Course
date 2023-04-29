package org.example;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Supplier extends Company {
    public Supplier() {
    }

    private String bankAccountNumber;

    public Supplier(String companyName, String street, String city, String zipCode, String banckAccountNumber) {
        super(companyName,street,city,zipCode);
        this.bankAccountNumber = banckAccountNumber;
    }



//    private Adress adress;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
//    @JoinColumn(name="supplier_id")
    private Set<Product> productsGroup;

    public Set<Product> getProductsGroup() {
        return productsGroup;
    }

    public void addToProductsGroup(Product product) {
        if (this.productsGroup==null){
            this.productsGroup = new HashSet<Product>();
        }
        this.productsGroup.add(product);
    }
}
