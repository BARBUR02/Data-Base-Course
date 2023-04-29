package org.example;

import javax.persistence.Embeddable;

@Embeddable
public class Adress {
    private String street;
    private String city;

    public Adress() {
    }

    public Adress(String street, String city, String zipCode) {
        this.street = street;
        this.city = city;
        this.zipCode = zipCode;
    }

    private String zipCode;
}
