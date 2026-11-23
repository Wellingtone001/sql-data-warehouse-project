-- 1. Check for orphaned/unmatched keys in fact_sales (Should return 0 rows)
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;

-- 2. Verify row counts across all 3 Gold views
SELECT 'dim_customers' AS table_name, COUNT(*) AS row_count FROM gold.dim_customers
UNION ALL
SELECT 'dim_products', COUNT(*) FROM gold.dim_products
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM gold.fact_sales;
