# terraform-azure-postgresql-creation
Automating PostgreSQL Database Deployment with Terraform and Azure
## **Project Overview**
This project automates the provisioning of a **PostgreSQL database** on **Azure** using **Terraform**. The project also ensures secure state management with Azure Blob Storage and demonstrates database accessibility through tools like **DBeaver**.

## **Key Features**
- **Infrastructure as Code**: Automates resource creation with Terraform.
- **Remote State Management**: Stores Terraform state files in Azure Blob Storage.
- **Database Creation**: Sets up PostgreSQL server and database with defined configurations.
- **Verification**: Demonstrates server logs verification and database access.

---

## **Architecture**
Below is the architecture diagram for the project:

```plaintext
+-----------------------------+      +---------------------------+
|      Terraform CLI          |      |      Azure Resources     |
|  (Run Terraform Commands)   |      |  - PostgreSQL Server     |
|                             | ---> |  - PostgreSQL Database   |
+-----------------------------+      |  - Azure Blob Storage    |
                                      |  (For State Management) |
                                      +-------------------------+

   +---------------------------+       +--------------------------+
   | Azure Server Logs         | ----> |  Verifying Logs          |
   +---------------------------+       +--------------------------+

+-----------------------------+
|   DBeaver Database Client   |
| (Access PostgreSQL Database)|
+-----------------------------+
```

---

## **Technologies Used**
- **Terraform**: Infrastructure as Code tool for resource provisioning.
- **Azure**: Cloud platform for hosting PostgreSQL server and storage.
- **Azure Blob Storage**: Used to securely store Terraform state files.
- **DBeaver**: Database client to connect and verify PostgreSQL setup.
- **GitHub**: Version control for project code and assets.

---

## **Project Setup**

### **1. Prerequisites**
Ensure you have the following installed:
- Terraform CLI
- Azure CLI
- DBeaver (or any database client)
- Git

Login to Azure using:
```bash
az login
```

### **2. Directory Structure**


terraform-azure-postgresql
│
├── main.tf               # PostgreSQL server and DB configuration
├── backend.tf            # Azure Blob Storage backend
├── variables.tf          # Terraform variables (optional)
├── README.md             # Project documentation
└── screenshots/          # Images for verification
```

---

## **3. Terraform Configuration**
### **Backend Configuration (backend.tf)**
Securely manage the Terraform state in Azure Blob Storage:


terraform {
  backend "azurerm" {
    resource_group_name  = "Sowmi_RG"
    storage_account_name = "terraformstate12341712"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }
}


### **Resource Configuration (main.tf)**
Provision PostgreSQL server and database:

```hcl
# PostgreSQL Server
resource "azurerm_postgresql_server" "postgresqlserver1" {
  name                = "postgresqlserver1678945unique"
  resource_group_name = "Sowmi_RG"
  location            = "East US"

  sku_name                       = "B_Gen5_2"
  storage_mb                     = 5120
  backup_retention_days          = 7
  geo_redundant_backup_enabled   = false
  auto_grow_enabled              = true

  administrator_login            = "psqladmin"
  administrator_login_password   = "H@Sh1CoR3!"
  version                        = "9.5"
  ssl_enforcement_enabled        = true
}

# PostgreSQL Database
resource "azurerm_postgresql_database" "postgresqldb" {
  name                = "postgresqldb"
  resource_group_name = "Sowmi_RG"
  server_name         = azurerm_postgresql_server.postgresqlserver1.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

  lifecycle {
    prevent_destroy = true
  }
}
```

### **Terraform Commands**
Run the following commands to deploy the resources:
```bash
terraform init      # Initialize Terraform and backend
terraform plan      # View the resource creation plan
terraform apply     # Create resources in Azure
```

---

## **4. Verification**

### **Server Logs (Azure Portal)**
After running the Terraform code, verify PostgreSQL server creation in the Azure Portal:

### **Database Access (DBeaver)**
Use DBeaver to connect to the PostgreSQL server and validate the database:

- **Host**: `postgresqlserver1678945unique.postgres.database.azure.com`
- **User**: `**************`
- **Password**: `**********`

![DBeaver Connection](screenshots/db_connection.jpg)

---

## **5. Results**
- PostgreSQL server and database were successfully created using Terraform.
- State management is securely configured using Azure Blob Storage.
- Logs verified in Azure Portal confirm successful deployment.
- Database connection validated using DBeaver.

---

## **6. Conclusion**
This project showcases the power of Infrastructure as Code (IaC) with Terraform for provisioning cloud resources. By leveraging Azure for state management and PostgreSQL hosting, the setup is:

- **Automated**: Eliminates manual configurations.
- **Secure**: Uses Azure Blob Storage for state management.
- **Scalable**: Can be extended for other resources.

---

## **7. Future Improvements**
- Implement **CI/CD pipelines** to automate Terraform deployments using tools like GitHub Actions.
- Use **Azure Key Vault** for secure storage of sensitive credentials.
- Add **monitoring and alerts** for PostgreSQL using Azure Monitor.

---

## **8. Repository Structure**

terraform-azure-postgresql
│
├── main.tf
├── backend.tf
├── README.md
├── screenshots/
│   ├── azure_server_logs.jpg
│   └── db_connection.jpg
└── .gitignore
```


---

## **9. References**
- [Terraform Documentation](https://www.terraform.io/docs)
- [Azure PostgreSQL Documentation](https://learn.microsoft.com/en-us/azure/postgresql/)

---

## **Author**
SowmiyaJS
