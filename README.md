 SQL Data Warehouse & Analytics Project

An end-to-end **Data Engineering and Data Warehousing project** built with Microsoft SQL Server. This project demonstrates the development of a modern analytical data warehouse, from raw CRM and ERP data ingestion to data cleansing, dimensional modeling, and business-ready analytics.

The solution implements the **Medallion Architecture (Bronze → Silver → Gold)** and applies dimensional modeling principles to transform raw operational data into structured, analytics-ready datasets.

---

 Project Overview

The objective of this project is to design and implement a centralized SQL data warehouse that integrates data from multiple CRM and ERP source systems.

The warehouse provides a structured foundation for analytical queries, business intelligence, and KPI reporting.

Architecture: Medallion Architecture

The data warehouse is organized into three layers:
 1. Bronze Layer — Raw Data Ingestion

The Bronze layer serves as the initial landing zone for source data.

- Ingests raw CRM and ERP datasets from CSV files.
- Uses SQL Server `BULK INSERT` for data ingestion.
- Implements stored procedures to manage the loading process.
- Preserves source data for traceability and downstream processing.

2. Silver Layer — Data Cleansing & Transformation

The Silver layer focuses on improving data quality and standardizing information across source systems.

Key operations include:

- Data cleansing and standardization.
- Duplicate detection and removal.
- Handling missing values (`NULL` and `'n/a'`).
- Data type validation and conversion.
- Standardization of product and customer attributes.
- Integration and consistency checks across CRM and ERP datasets.

Core tables processed:**
- `crm_cust_info`
- `crm_prd_info`
- `crm_sales_details`
- `erp_cust_az12`
- `erp_loc_a101`
- `erp_px_cat_g1v2`

 3. Gold Layer — Analytical Modeling

The Gold layer transforms cleansed Silver data into business-ready analytical views using dimensional modeling principles.

The project implements a **Star Schema** consisting of:

| Object | Description |
|---|---|
| `gold.dim_customers` | Customer dimension integrating CRM profiles with ERP demographic and geographical information. |
| `gold.dim_products` | Product dimension enriched with ERP category, subcategory, and maintenance information. |
| `gold.fact_sales` | Central sales fact containing transaction measures and references to customer and product dimensions. |

The dimensional model provides a simplified structure for analytical queries, reporting, and KPI calculations.

---
 Data Warehouse Architecture

The project follows this data flow:

```text
       CRM SOURCE DATA             ERP SOURCE DATA
       (CSV FILES)                 (CSV FILES)
             |                           |
             +-------------+-------------+
                           |
                           v
                 BRONZE LAYER
                  Raw Data Storage
                           |
                           v
                 SILVER LAYER
              Cleansing & Transformation
                           |
                           v
                   GOLD LAYER
                 Dimensional Modeling
                           |
                  +--------+--------+
                  |        |        |
                  v        v        v
               DIM_     DIM_     FACT_
             CUSTOMERS PRODUCTS  SALES
                           |
                           v
                  BUSINESS ANALYTICS
                    & KPI REPORTING




 Technology Stack

| Technology | Purpose |
|---|---|
| Microsoft SQL Server | Relational database engine and data warehouse storage |
| T-SQL | Data ingestion, transformation, validation, and analytical queries |
| SQL Server Management Studio (SSMS) | Database development and administration |
| Dimensional Modeling | Star Schema design and analytical data organization |
| Power BI Desktop | Business intelligence and KPI verification |
| Git & GitHub | Version control and project documentation |

---

 Repository Structure

```text
sql-data-warehouse-project/
│
├── datasets/
│   └── Raw CRM and ERP CSV source files
│
├── docs/
│   └── Architecture diagrams and data catalog
│
├── scripts/
│   ├── init_database.sql
│   │
│   ├── bronze/
│   │   └── Raw table definitions and loading procedures
│   │
│   ├── silver/
│   │   └── Cleansing and transformation procedures
│   │
│   └── gold/
│       └── Analytical views (Facts & Dimensions)
│
├── tests/
│   └── Data quality checks and business KPI queries
│
├── LICENSE
│
└── README.md
```

---
 Data Quality & Validation

Data quality checks are performed to assess the reliability and consistency of the analytical layer.

Key validation activities include:

- Identifying duplicate records.
- Checking for missing and invalid values.
- Verifying relationships between fact and dimension tables.
- Detecting orphaned customer and product keys.
- Comparing row counts across Gold-layer objects.
- Validating analytical results and business KPIs.

**Validation results:**
- Zero orphaned customer and product keys reported by the Gold-layer referential integrity checks.
- Duplicate detection and data quality checks performed across the warehouse.
- Row-count verification performed across the three Gold-layer objects.

---
 Key Business Insights

Analytical queries against the Gold layer produced the following reported results:

| Business Metric | Result |
|---|---:|
| Total Revenue | Approximately $29.3 Million |
| Units Sold | 60,000+ |
| Top Performing Category | Bikes |
| Bikes' Revenue Contribution | Approximately 96% |

Additional category contributions came from Accessories and Clothing.

These results demonstrate how raw operational data can be transformed into business insights through SQL-based analytical modeling.

---

 Project Setup & Execution
 Prerequisites

Before running the project, ensure you have:

- Microsoft SQL Server installed and running.
- SQL Server Management Studio (SSMS).
- Git installed.
- Access to the project's CRM and ERP CSV datasets.

### 1. Clone the Repository

```bash
git clone <YOUR-REPOSITORY-URL>
```

Navigate into the project directory:

```bash
cd sql-data-warehouse-project

### 2. Initialize the Database

Open SSMS and execute:

```text
scripts/init_database.sql
```

This script creates the `Datawarehouse` database and the Bronze, Silver, and Gold schemas.

### 3. Execute the Bronze Layer

Run the scripts inside:

```text
scripts/bronze/
```

This creates the raw tables and loading procedures used to ingest the source CSV datasets.

Ensure the CSV file paths in the loading procedures match your local environment.

### 4. Execute the Silver Layer

Run the scripts inside:

```text
scripts/silver/
```

This creates the Silver tables and transformation procedures responsible for cleansing and standardizing the raw data.

### 5. Build the Gold Layer

Execute:

```text
scripts/gold/ddl_gold.sql
```

This creates the analytical views:

- `gold.dim_customers`
- `gold.dim_products`
- `gold.fact_sales`

### 6. Run Data Quality Checks

Execute the queries inside:

```text
tests/
```

Use these scripts to verify data consistency, fact-to-dimension relationships, row counts, and analytical results.

---
 Project Objectives & Learning Outcomes

Through this project, I gained practical experience in:

- Designing and implementing a SQL-based data warehouse.
- Understanding and applying the Medallion Architecture.
- Ingesting raw data from multiple source systems.
- Developing SQL-based data cleansing and transformation processes.
- Applying dimensional modeling and Star Schema design.
- Working with fact tables, dimension tables, and surrogate keys.
- Integrating data from CRM and ERP systems.
- Implementing data quality and referential integrity checks.
- Writing analytical SQL queries to derive business insights.

---

Author

**Wellingtone Dindi**

Software Engineering Student | Aspiring Data Engineer

Interested in building reliable data pipelines, designing analytical data systems, and transforming raw data into meaningful business insights.

---

 License

This project is distributed under the MIT License. See the `LICENSE` file for details.
