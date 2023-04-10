using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JakubBarberEFProducts.Migrations
{
    /// <inheritdoc />
    public partial class testing_TPH : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Suppliers_SupplierID",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_SupplierID",
                table: "Products");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Suppliers",
                table: "Suppliers");

            migrationBuilder.DropColumn(
                name: "SupplierID",
                table: "Products");

            migrationBuilder.RenameTable(
                name: "Suppliers",
                newName: "Companies");

            migrationBuilder.RenameColumn(
                name: "SupplierID",
                table: "Companies",
                newName: "CompanyID");

            migrationBuilder.AlterColumn<string>(
                name: "ProductName",
                table: "Products",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "TEXT");

            migrationBuilder.AddColumn<int>(
                name: "SupplierCompanyID",
                table: "Products",
                type: "INTEGER",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Street",
                table: "Companies",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "TEXT");

            migrationBuilder.AlterColumn<string>(
                name: "CompanyName",
                table: "Companies",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "TEXT");

            migrationBuilder.AlterColumn<string>(
                name: "City",
                table: "Companies",
                type: "TEXT",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "TEXT");

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

            migrationBuilder.AddColumn<string>(
                name: "zipCode",
                table: "Companies",
                type: "TEXT",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Companies",
                table: "Companies",
                column: "CompanyID");

            migrationBuilder.CreateIndex(
                name: "IX_Products_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Companies_SupplierCompanyID",
                table: "Products",
                column: "SupplierCompanyID",
                principalTable: "Companies",
                principalColumn: "CompanyID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Companies_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropIndex(
                name: "IX_Products_SupplierCompanyID",
                table: "Products");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Companies",
                table: "Companies");

            migrationBuilder.DropColumn(
                name: "SupplierCompanyID",
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

            migrationBuilder.DropColumn(
                name: "zipCode",
                table: "Companies");

            migrationBuilder.RenameTable(
                name: "Companies",
                newName: "Suppliers");

            migrationBuilder.RenameColumn(
                name: "CompanyID",
                table: "Suppliers",
                newName: "SupplierID");

            migrationBuilder.AlterColumn<string>(
                name: "ProductName",
                table: "Products",
                type: "TEXT",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "SupplierID",
                table: "Products",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<string>(
                name: "Street",
                table: "Suppliers",
                type: "TEXT",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "CompanyName",
                table: "Suppliers",
                type: "TEXT",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "City",
                table: "Suppliers",
                type: "TEXT",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "TEXT",
                oldNullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Suppliers",
                table: "Suppliers",
                column: "SupplierID");

            migrationBuilder.CreateIndex(
                name: "IX_Products_SupplierID",
                table: "Products",
                column: "SupplierID");

            migrationBuilder.AddForeignKey(
                name: "FK_Products_Suppliers_SupplierID",
                table: "Products",
                column: "SupplierID",
                principalTable: "Suppliers",
                principalColumn: "SupplierID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
