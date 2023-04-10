using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JakubBarberEFProducts.Migrations
{
    /// <inheritdoc />
    public partial class ManyToManyInvoiceProduct : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Invoices",
                columns: table => new
                {
                    InvoiceID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Quantity = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Invoices", x => x.InvoiceID);
                });

            migrationBuilder.CreateTable(
                name: "InvoiceProduct",
                columns: table => new
                {
                    ProductsInvoiceID = table.Column<int>(type: "INTEGER", nullable: false),
                    ProductsProductID = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_InvoiceProduct", x => new { x.ProductsInvoiceID, x.ProductsProductID });
                    table.ForeignKey(
                        name: "FK_InvoiceProduct_Invoices_ProductsInvoiceID",
                        column: x => x.ProductsInvoiceID,
                        principalTable: "Invoices",
                        principalColumn: "InvoiceID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_InvoiceProduct_Products_ProductsProductID",
                        column: x => x.ProductsProductID,
                        principalTable: "Products",
                        principalColumn: "ProductID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_InvoiceProduct_ProductsProductID",
                table: "InvoiceProduct",
                column: "ProductsProductID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "InvoiceProduct");

            migrationBuilder.DropTable(
                name: "Invoices");
        }
    }
}
