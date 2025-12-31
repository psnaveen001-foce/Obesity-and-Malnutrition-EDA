# Obesity-and-Malnutrition-EDA

# 📊 Nutrition Paradox — Exploratory Data Analysis & PowerBI Integration

This repository contains a comprehensive data analytics pipeline exploring global obesity and malnutrition data using Python, SQL, and Power BI. It demonstrates end-to-end analysis — from raw data cleaning and exploration to SQL database integration and interactive visualizations.

# 📌 Project Overview

Worldwide, malnutrition and obesity represent a nutrition paradox — simultaneous challenges of undernutrition and overnutrition that affect populations differently across regions, age groups, and genders.
This project aims to explore trends, disparities, and relationships in global prevalence data sourced from authoritative public health datasets.

This document outlines the core concepts covered, the analytical workflow applied, and the reasoning behind integrating SQL and Power BI into the analytics pipeline.

# 🧠 Core Concepts Covered
🔍 1. Exploratory Data Analysis (EDA)

✔ Inspecting dataset structure, overview of variables, and data quality.

✔ Understanding distributions, missing values, and categorical versus continuous features.

✔ Deriving useful metafeatures such as confidence interval width (CI_Width) and levels of malnutrition/obesity.

✔ This phase answers questions like:

✔ How do obesity rates vary by region, age, or gender?

✔ What are patterns and trends over time?

# 🧩 2. Data Cleaning & Preprocessing

* Identifying and handling missing values.

* Converting object/categorical columns into proper data types for analysis.

* Generating derived variables, such as obesity category labels and confidence band widths.

* Ensuring readiness of datasets for both SQL ingestion and BI use.

# 🗄️ 3. SQL Database Integration

The cleaned datasets are stored in a cloud SQL database (Nutrition_paradox) to enable scalable querying and BI integration.

You’ll find:

* Creation of the database and schema.

* Bulk insertion of over 27,000 records for both obesity and malnutrition.

* Structured SQL queries to extract analytical results.

This enables:

* Efficient data retrieval for downstream analysis.

* A clear separation between data storage and visualization layers.

* Example SQL pattern used for analytics:

# 📊 4. SQL Query Library

A collection of 25+ SQL queries designed to:

Category	Purpose

✔ Obesity trends	Regional & gender analysis over time

✔ Malnutrition trends	Comparisons by region, age, and country

✔ Combined analysis	Nutrition paradox comparisons for selected countries

✔ Data reliability	Confidence interval based reliability summaries

✔ These queries form the backbone of your exploratory and comparative analysis logic.

# 📈 5. Power BI Visualization

The SQL database feeds into Power BI to create interactive dashboards based on analytic outputs:

Visualizations include:

✔ Line charts — Trends over time

✔ Bar charts — Top countries by measure

✔ Stacked bars — Gender comparisons

✔ Heatmaps — Distribution of uncertainty (CI Width)

✔ Scatter & dual-line plots — Country-level paradox comparisons

✔ Treemaps & decomposition trees — Hierarchical insights

These visuals help communicate:

✔ Global vs. regional patterns

✔ Disparities by gender or age

✔ Coexistence of high obesity and high malnutrition

# 📦 How to Use This Repository

* Open the Colab Notebook

* Run all cells to import and clean datasets.

* Generate summary tables and EDA visuals.

* Create SQL Schema

* Use the provided engine connection code to connect to the cloud SQL instance.

* Create the Nutrition_paradox database and tables.

* Insert Cleaned Data

* Bulk insert processed data (df_obesity and df_malnutrition) into SQL.

* Run SQL Queries

* Use the query dictionary to run and collect results with Python/pandas.

* Export to CSV if needed for BI.

* Connect SQL to Power BI

* Use the cloud SQL connection to pull data directly into Power BI.

* Build dashboards using the recommended visuals.

# 🧑‍💻 Tools & Technologies
* Layer	Technology
  
* Data Wrangling	Python, pandas
  
* SQL Engine	TiDB Cloud / MySQL compatible
  
* Analytics	SQL queries
  
* Visualization	Power BI
  
* Notebook	Colab (Python environment)
  
# 🚀 What This Project Achieves

📌 Bridges raw public health data with advanced analytics

📌 Demonstrates cloud SQL integration from Python workflows

📌 Connects data to modern BI tools (Power BI)

📌 Enables multi-dimensional interrogation of nutrition data

📌 Supports hypothesis testing and visualization for nutrition policy insights

# 🔍 Conclusion

This project not only unpacks obesity and malnutrition trends globally but also illustrates practical data engineering — ingesting, transforming, storing, querying, and visualizing data in real world analytical environments.

It’s a repeatable and scalable data analysis pipeline suitable for industry use or academic exploration.

## Author - PS Naveen Kumar
