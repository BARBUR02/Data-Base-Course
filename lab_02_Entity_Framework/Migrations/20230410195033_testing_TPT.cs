using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JakubBarberEFProducts.Migrations
{
    /// <inheritdoc />
    public partial class testing_TPT : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Companies_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropColumn(
                name: "BankAccountNumber",
                table: "Companies");

            migrationBuilder.DropColumn(
                name: "Discount",
                table: "Companies");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "Companies");

            migrationBuilder.CreateTable(
                name: "Customers",
                columns: table => new
                {
                    CompanyID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Discount = table.Column<double>(type: "REAL", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Customers", x => x.CompanyID);
                    table.ForeignKey(
                        name: "FK_Customers_Companies_CompanyID",
                        column: x => x.CompanyID,
                        principalTable: "Companies",
                        principalColumn: "CompanyID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Suppliers",
                columns: table => new
                {
                    CompanyID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    BankAccountNumber = table.Column<long>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Suppliers", x => x.CompanyID);
                    table.ForeignKey(
                        name: "FK_Suppliers_Companies_CompanyID",
                        column: x => x.CompanyID,
                        principalTable: "Companies",
                        principalColumn: "CompanyID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Suppliers_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID",
                principalTable: "Suppliers",
                principalColumn: "CompanyID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropTable(
                name: "Customers");

            migrationBuilder.DropTable(
                name: "Suppliers");

            migrationBuilder.AddColumn<long>(
                name: "BankAccountNumber",
                table: "Companies",
                type: "INTEGER",
                nullable: true);

            migrationBuilder.AddColumn<double>(
                name: "Discount",
                table: "Companies",
                type: "REAL",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "Companies",
                type: "TEXT",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Companies_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID",
                principalTable: "Companies",
                principalColumn: "CompanyID");
        }
    }
}
