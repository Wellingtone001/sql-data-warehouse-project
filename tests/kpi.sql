-- ============================================================================
-- 1. EXECUTIVE SUMMARY (Big Numbers KPI Report)
-- ============================================================================
SELECT 'Total Revenue' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity Sold', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Selling Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Unique Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Active Products', COUNT(product_key) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;

-- ============================================================================
-- 2. REVENUE BY PRODUCT CATEGORY (Product Performance)
-- ============================================================================
SELECT 
    p.category,
    SUM(f.sales_amount) AS total_revenue,
    SUM(f.quantity) AS total_units_sold,
    ROUND(CAST(SUM(f.sales_amount) AS FLOAT) / (SELECT SUM(sales_amount) FROM gold.fact_sales) * 100, 2) AS revenue_share_pct
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

-- ============================================================================
-- 3. REVENUE & CUSTOMERS BY COUNTRY (Geographic Performance)
-- ============================================================================
SELECT 
    c.country,
    COUNT(DISTINCT c.customer_key) AS total_customers,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_revenue DESC;

-- ============================================================================
-- 4. TOP 10 VIP CUSTOMERS (Customer Value)
-- ============================================================================
SELECT TOP 10
    c.customer_key,
    c.first_name,
    c.last_name,
    c.country,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.sales_amount) AS total_spent
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name, c.country
ORDER BY total_spent DESC;
