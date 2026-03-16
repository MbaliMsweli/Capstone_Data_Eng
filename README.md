# Retail Data Engineering Project

Staging & Data Warehouse Implementation using SQL Server and SSIS

# Project Overview

This project simulates a real-world enterprise retail data platform built using Microsoft SQL Server and SQL Server Integration Services (SSIS).

The goal of the project was to design, build, secure, and automate a complete data engineering pipeline consisting of:

### A Staging Database

### A Dimensional Data Warehouse

### An Automated SSIS ETL Pipeline

### Analytical Reporting Views

The dataset consists of 12 monthly CSV files (January–December 2025).
Each file contains 100,000 retail transaction records.

The system ingests raw retail data, loads it into a staging environment, transforms it through an ETL pipeline, and stores it in a Star Schema Data Warehouse optimized for reporting and analytics.

# Architecture Overview

The solution follows a two-layer enterprise data architecture.

CSV Files (Raw Data)
        │
        ▼
RetailStaging Database
(Raw ingestion only)
        │
        ▼
SSIS ETL Pipeline
(Transformation + Automation)
        │
        ▼
RetailDataWarehouse
(Star Schema Model)
        │
        ▼
Analytical Views
(SQL Reporting Layer)

This architecture separates raw ingestion from analytical storage, which improves:

scalability

performance

maintainability

data quality control

# Technologies Used
SSMS	
SSIS (SQL Server Integration Services)for ETL automation
CSV Files	to Source data
draw.io	for Data warehouse design

Two databases were created as required by the project.

## 1. RetailStaging

#### Purpose:
Store raw data exactly as it appears in the CSV files.

### Characteristics:

Raw ingestion only

No transformations

Used as the ETL landing zone

Supports data validation and debugging

This layer ensures the original source data is preserved before transformations occur.

# 2. RetailDataWarehouse

#### Purpose:
Store structured analytical data optimized for reporting and business intelligence.

### Characteristics:

Star Schema design

Dimension tables

### Fact tables

Optimized for analytics queries

Data Warehouse Design

The warehouse uses a Star Schema architecture.

A Star Schema consists of:

One central Fact table

Multiple Dimension tables

This design improves:

query performance

analytical flexibility

reporting simplicity

### Fact Table
FactSales

One row per product per transaction per date

Measures stored:

Quantity

UnitPrice

TotalAmount

Foreign Keys:

ProductKey

StoreKey

DateKey

CashierKey

The FactSales table stores the core business metrics.

### Dimension Tables
DimProduct

Stores product information.

Columns include:

ProductKey (Surrogate Key)

ProductID

Barcode

ProductName

Category

### DimStore

Stores store location information.

Columns include:

StoreKey

StoreID

StoreName

Province

Region

### DimDate

Enables time-based analysis.

Columns include:

DateKey

FullDate

Day

Month

MonthName

Quarter

Year

IsWeekend

### DimCashier

Stores cashier information.

Columns include:

CashierKey

CashierName

## SSIS ETL Pipeline

The ETL pipeline was implemented using SQL Server Integration Services (SSIS).

Responsibilities of the SSIS package:

Automatically load CSV files

Orchestrate ETL workflow

Execute stored procedures

Load staging tables

Populate the data warehouse

#### Why Stored Procedures Were Used in SSIS

In the SSIS package, the main tasks execute stored procedures responsible for:

Creating warehouse tables

Loading dimension tables

Loading the FactSales table

Example:

EXEC CreateWarehouseTables
EXEC Load_DimProduct
EXEC Load_DimStore
EXEC Load_DimDate
EXEC Load_DimCashier
EXEC Load_FactSales

This approach follows best practices in enterprise ETL development.

### Benefits of Using Stored Procedures
1. Separation of Responsibilities

SSIS manages workflow orchestration while SQL Server handles data transformation logic.

This keeps the system modular and easier to maintain.

2. Better Performance

SQL Server executes queries inside the database engine, which is faster than performing heavy transformations inside SSIS.

Benefits:

reduced data movement

optimized execution plans

faster data processing

3. Reusability

Stored procedures can be reused in:

SSIS packages

SQL Agent jobs

reporting queries

other ETL processes

4. Easier Debugging

Stored procedures can be executed directly in SQL Server Management Studio for testing and troubleshooting.

5. Maintainability

Business logic is centralized in SQL instead of being scattered across multiple SSIS components.

#### January CSV File Error

During the ingestion process, the January CSV file failed to load into the staging database.

#### Cause of the Error

The file structure did not match the expected format used by the other monthly files.

Possible causes include:

missing columns

extra columns

incorrect delimiter

incorrect data types

corrupted rows

encoding issues

SSIS requires consistent column structure across files.

If even one column differs, the pipeline cannot map the data correctly and the load fails.

Solution Implemented

The correct approach was to request a corrected version of the file instead of modifying the corrupted data.

This follows proper data engineering practice because:

source data integrity must be preserved

ETL pipelines should not alter raw source data

corrections should come from the source system

Once the corrected file was received, the pipeline successfully processed the data.

### Foreach Loop for Loading CSV Files

To automate ingestion of the 12 monthly files, the SSIS package uses a Foreach Loop Container.

Instead of manually loading each file, the loop processes all CSV files automatically.

Example folder:

RetailFiles/

January.csv
February.csv
March.csv
April.csv
May.csv
June.csv
July.csv
August.csv
September.csv
October.csv
November.csv
December.csv

The loop runs once for each file.

Foreach Loop Configuration

Enumerator:

Foreach File Enumerator

Folder:

Retail CSV Data Folder

Files:

*.csv

This allows the package to process all CSV files dynamically.

Variable Used in the Loop

A variable stores the current file being processed.

Variable:

User::CurrentFilePath

Each loop iteration updates the variable.

Example:

Loop	File Loaded
1	January.csv
2	February.csv
3	March.csv
...	...
12	December.csv

The variable is then used in the Flat File Source connection manager.

### Advantages of the Foreach Loop
Automation

All files load automatically with a single package execution.

Scalability

New files can be added later without changing the SSIS package.

Reduced Complexity

Instead of creating 12 separate pipelines, one pipeline processes all files.

Easier Maintenance

Changes to the pipeline only need to be made once.

Analytical Views Created

### The following views were created for reporting and analytics:

vw_DailySales

vw_StorePerformance

vw_CategoryRevenue

vw_Top10Products

vw_CashierPerformance

vw_ProvinceRevenue

vw_MonthlySalesSummary

These views support business intelligence analysis.

### Business Questions Answered

The data warehouse allows answering important business questions such as:

Which store generated the highest revenue?

Which province performs best overall?

Which product category contributes the highest revenue?

Who is the top-performing cashier?

What is the average daily revenue?

Which month had the highest sales?

What percentage of revenue comes from Toys?

Identify the bottom 5 products by revenue

Compare Gauteng vs Western Cape performance

Identify trends in monthly sales

Skills Demonstrated

# This project demonstrates the following data engineering skills:

Enterprise database architecture

SSIS ETL automation

Dimensional modelling

Star schema design

SQL data transformation

Role-based database security

analytical SQL reporting

data quality management

Project Outcome

The final system is a fully automated retail analytics platform capable of:

ingesting large retail datasets

transforming raw data into analytical structures

providing secure access to users

supporting advanced business analysis

This project demonstrates real-world data engineering practices used in enterprise data platforms.
