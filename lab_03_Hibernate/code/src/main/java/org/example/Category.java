package org.example;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Category {
    @Id
    @GeneratedValue( strategy = GenerationType.AUTO)
    private int CategoryID;
    private String Name;

    public Category() {
    }

    public Category(String name) {
        Name = name;
    }

    @OneToMany
    @JoinColumn(name="category_id")
    private List<Product> Products = new ArrayList<>();

    public void addProduct(Product product){
        this.Products.add(product);
    }

    public String getName() {
        return Name;
    }

    public List<Product> getProducts() {
        return Products;
    }
}
