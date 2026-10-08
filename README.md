SAP ABAP Customer & Material ALV Report

Project Overview

This project is an SAP ABAP report developed to display customer and material-related sales information using an ALV report.

The report retrieves data from standard SAP tables and displays customer details, material details, quantity, unit, and plant based on user-selected criteria.

Technologies Used

- SAP ABAP
- SAP GUI / ABAP Development Tools (Eclipse)
- Open SQL
- ALV
- Object-Oriented ABAP
- Internal Tables
- Selection Screens

SAP Tables Used

Table| Purpose
VBAK| Sales Document Header
VBAP| Sales Document Item
KNA1| Customer Master
MARA| Material Master
MAKT| Material Description

Selection Criteria

The user can provide:

- Sales Organization
- Creation Date
- Customer Number
- Material Number

The creation date is automatically initialized with the last 90 days.

Output Fields

The ALV output displays:

- Customer Number
- Customer Name
- Material Number
- Material Description
- Material Type
- Quantity
- Unit
- Plant

Project Features

- Input validation
- Sales Organization validation
- Customer Number validation
- Material Number validation
- Date range validation
- Database joins using Open SQL
- ALV display
- Object-Oriented ABAP implementation
- Error and no-data handling

Program Flow

Selection Screen
↓
Input Validation
↓
Fetch Data from SAP Tables
↓
Process Internal Table
↓
Display ALV
↓
User Analysis

Main Class

"ZCL_CUST_MAT1748"

The class contains:

- "VALIDATE_INPUTS"
- "FETCH_DATA"
- "DISPLAY_ALV"

ALV

The project uses "CL_SALV_TABLE" for displaying the final output in the Object-Oriented version.

The classical version uses ALV field catalog functionality.

Purpose

The main purpose of this project is to provide a simple and user-friendly report for analyzing customer and material sales information in SAP.

Author

Shaik Gousiya
