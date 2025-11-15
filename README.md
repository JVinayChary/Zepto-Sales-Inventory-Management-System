# Zepto Sales & Inventory Management System (SQL Project)

# Project Overview
This SQL project transforms raw CSV data into a well-structured, relational database with clean tables, relationships, and analytical insights.
It performs SQL transformations, joins, and aggregations to provide meaningful output for purposes of sales tracking, inventory planning, and business decision-making.

This project indeed dismisses the completion of building an elaborate Sales and Inventory Management System for Zepto with MYSQL Workbench.
It covers raw data import, database normalization, ER diagram modeling, dummy data creation, and 38 SQL queries to generate business insights across categories, products, inventory, orders, payments, and deliveries.

# Objectives

Import and clean raw CSV data using SQL
Normalize tables of Category, Product, Inventory, Orders, etc.
To delineate the relationships, use an ER Diagram.
Populate with dummy data that is realistic for testing purposes.
Execute analytic SQL queries: Category, Product, Inventory, Orders, Revenue.
Make real-time analytics available as a part of decision-making.

# Tools
MySQL Workbench.
SQL Functions (DDL, DML, Joins, Aggregations)
CSV Data Import
ER Diagram Modeling

# Database Structure
Main Tables
* temp_zepto_raw — Table raw CSV data table
* Category — Category list
* Product — Product-level information
* Inventory — Stock & availability
* Customer — Dummy customers
* Orders— Records of orders
* Payment — Payment information
* Delivery — Delivery status

# Why Temp Table?
Used for initial CSV import → cleaned → inserted into normalized tables.

# Data Cleaning ?
* Converted `outOfStock` to VARCHAR to avoid import errors

* Removed duplicates

* Trimmed spaces + standardized text

Converted data types: price → DECIMAL, weight → INT, etc.

* Normalized data to 3NF

# Key Query Sections
This project includes 38 SQL queries, organized as:

1️⃣ Category-Level Queries
2️⃣ Product-Level Queries
3️⃣ Inventory-Level Queries
4️⃣ Orders / Customer / Payment Queries
5️⃣ Top-selling product per category Queries

# Conclusion

This project demonstrates practical skills in database design, SQL querying, data cleaning, and analytics.
It is a complete end-to-end solution to understand how real e-commerce systems, like Zepto, manage products, stock, orders, payments, and deliveries.

# Author 
JANGAM VINAY CHARY SQL | Data Analytics
