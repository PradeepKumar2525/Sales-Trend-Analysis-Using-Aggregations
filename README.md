# 📊 Blinkit Monthly Revenue & Order Volume Analysis (with MoM Growth)

##  Overview
This SQL project calculates **monthly revenue**, **order volume**, and **month-over-month (MoM) growth percentages** for Blinkit's sales data.  
It uses **three table joins** (`blinkit_products`, `blinkit_order_items`, and `blinkit_orders`) and SQL window functions to track sales trends over time.

---

##  Dataset Structure

### **Tables Used**
1. **blinkit_products**
   - `product_id` (PK)
   - `unit_price` (numeric)
2. **blinkit_order_items**
   - `order_id`
   - `product_id`
   - `quantity`
3. **blinkit_orders**
   - `order_id` (PK)
   - `order_date` (date/datetime)

---

##  Query Logic

###  Aggregate Monthly Data
- **`EXTRACT(YEAR FROM order_date)`** → Extract year
- **`EXTRACT(MONTH FROM order_date)`** → Extract month
- **`SUM(unit_price)`** → Monthly revenue
- **`COUNT(DISTINCT order_id)`** → Monthly order volume
- **JOINs**:
  - `blinkit_products` ↔ `blinkit_order_items` via `product_id`
  - `blinkit_order_items` ↔ `blinkit_orders` via `order_id`

###  Calculate MoM Growth
- **`LAG()`** → Gets previous month’s value for comparison.
- Growth formula:  
