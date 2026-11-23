--we are starting to buid our gold layer --
-- Check 1: Verify zero duplicate customer IDs after joining (Expect 0 rows)
SELECT cst_id, COUNT(*) AS row_count
FROM (
    SELECT ci.cst_id
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
    LEFT JOIN silver.erp_loc_a101 la ON ci.cst_key = la.cid
) t
GROUP BY cst_id
HAVING COUNT(*) > 1;

-- Check 2: Inspect how CRM Gender and ERP Gender merge
SELECT DISTINCT
    ci.cst_gndr,
    ca.gen,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the master source
        ELSE COALESCE(ca.gen, 'n/a')               -- Fallback to ERP if CRM is 'n/a'
    END AS new_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
ORDER BY 1, 2;
