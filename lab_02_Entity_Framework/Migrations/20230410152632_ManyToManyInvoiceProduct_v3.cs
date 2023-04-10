using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JakubBarberEFProducts.Migrations
{
    /// <inheritdoc />
    public partial class ManyToManyInvoiceProduct_v3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_InvoiceProduct_Invoices_ProductsInvoiceID",
                table: "InvoiceProduct");

            migrationBuilder.RenameColumn(
                name: "ProductsInvoiceID",
                table: "InvoiceProduct",
                newName: "InvoicesInvoiceID");

            migrationBuilder.AddForeignKey(
                name: "FK_InvoiceProduct_Invoices_InvoicesInvoiceID",
                table: "InvoiceProduct",
                column: "InvoicesInvoiceID",
                principalTable: "Invoices",
                principalColumn: "InvoiceID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_InvoiceProduct_Invoices_InvoicesInvoiceID",
                table: "InvoiceProduct");

            migrationBuilder.RenameColumn(
                name: "InvoicesInvoiceID",
                table: "InvoiceProduct",
                newName: "ProductsInvoiceID");

            migrationBuilder.AddForeignKey(
                name: "FK_InvoiceProduct_Invoices_ProductsInvoiceID",
                table: "InvoiceProduct",
                column: "ProductsInvoiceID",
                principalTable: "Invoices",
                principalColumn: "InvoiceID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
