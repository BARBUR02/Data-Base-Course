﻿// <auto-generated />
using System;
using JakubBarberEFProducts;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace JakubBarberEFProducts.Migrations
{
    [DbContext(typeof(ProductContext))]
    [Migration("20230410200547_testing_TPT_2")]
    partial class testing_TPT_2
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "7.0.4");

            modelBuilder.Entity("InvoiceProduct", b =>
                {
                    b.Property<int>("InvoicesInvoiceID")
                        .HasColumnType("INTEGER");

                    b.Property<int>("ProductsProductID")
                        .HasColumnType("INTEGER");

                    b.HasKey("InvoicesInvoiceID", "ProductsProductID");

                    b.HasIndex("ProductsProductID");

                    b.ToTable("InvoiceProduct");
                });

            modelBuilder.Entity("JakubBarberEFProducts.Company", b =>
                {
                    b.Property<int>("CompanyID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("City")
                        .HasColumnType("TEXT");

                    b.Property<string>("CompanyName")
                        .HasColumnType("TEXT");

                    b.Property<string>("Street")
                        .HasColumnType("TEXT");

                    b.Property<string>("zipCode")
                        .HasColumnType("TEXT");

                    b.HasKey("CompanyID");

                    b.ToTable("Companies");

                    b.UseTptMappingStrategy();
                });

            modelBuilder.Entity("JakubBarberEFProducts.Invoice", b =>
                {
                    b.Property<int>("InvoiceID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<int>("Quantity")
                        .HasColumnType("INTEGER");

                    b.HasKey("InvoiceID");

                    b.ToTable("Invoices");
                });

            modelBuilder.Entity("JakubBarberEFProducts.Product", b =>
                {
                    b.Property<int>("ProductID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("ProductName")
                        .HasColumnType("TEXT");

                    b.Property<int?>("SupplierCompanyID")
                        .HasColumnType("INTEGER");

                    b.Property<int>("UnitsOnStock")
                        .HasColumnType("INTEGER");

                    b.HasKey("ProductID");

                    b.HasIndex("SupplierCompanyID");

                    b.ToTable("Products");
                });

            modelBuilder.Entity("JakubBarberEFProducts.Customer", b =>
                {
                    b.HasBaseType("JakubBarberEFProducts.Company");

                    b.Property<double>("Discount")
                        .HasColumnType("REAL");

                    b.ToTable("Customers");
                });

            modelBuilder.Entity("JakubBarberEFProducts.Supplier", b =>
                {
                    b.HasBaseType("JakubBarberEFProducts.Company");

                    b.Property<long>("BankAccountNumber")
                        .HasColumnType("INTEGER");

                    b.ToTable("Suppliers");
                });

            modelBuilder.Entity("InvoiceProduct", b =>
                {
                    b.HasOne("JakubBarberEFProducts.Invoice", null)
                        .WithMany()
                        .HasForeignKey("InvoicesInvoiceID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("JakubBarberEFProducts.Product", null)
                        .WithMany()
                        .HasForeignKey("ProductsProductID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("JakubBarberEFProducts.Product", b =>
                {
                    b.HasOne("JakubBarberEFProducts.Supplier", "Supplier")
                        .WithMany("Products")
                        .HasForeignKey("SupplierCompanyID");

                    b.Navigation("Supplier");
                });

            modelBuilder.Entity("JakubBarberEFProducts.Customer", b =>
                {
                    b.HasOne("JakubBarberEFProducts.Company", null)
                        .WithOne()
                        .HasForeignKey("JakubBarberEFProducts.Customer", "CompanyID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("JakubBarberEFProducts.Supplier", b =>
                {
                    b.HasOne("JakubBarberEFProducts.Company", null)
                        .WithOne()
                        .HasForeignKey("JakubBarberEFProducts.Supplier", "CompanyID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("JakubBarberEFProducts.Supplier", b =>
                {
                    b.Navigation("Products");
                });
#pragma warning restore 612, 618
        }
    }
}