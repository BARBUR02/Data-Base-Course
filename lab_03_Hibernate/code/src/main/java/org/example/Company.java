package org.example;

import javax.persistence.*;

@Entity
//@SecondaryTable(name="ADDRESS_TBL")
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public class Company {
    public Company() {
    }

    public Company(String companyName, String street, String city, String zipCode) {
        CompanyName = companyName;
        this.street = street;
        this.city = city;
        this.zipCode = zipCode;
    }

    @Id
    @GeneratedValue( strategy = GenerationType.AUTO)
    private int SupplierID;

    public String getCompanyName() {
        return CompanyName;
    }

    public void setCompanyName(String companyName) {
        CompanyName = companyName;
    }

    protected String CompanyName;
//    @Column(table = "ADDRESS_TBL")
    protected String street;
//    @Column(table = "ADDRESS_TBL")
    protected String city;
//    @Column(table = "ADDRESS_TBL")
    protected String zipCode;

}
