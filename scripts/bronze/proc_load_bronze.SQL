Stored procedure :Load bronze layer 
Script Purpose:
   This stored procedure loads data into the 'bronze' schema from external CSV files.
   It performs the following actions:
   - Truncates the bronze tables before loading data.
   - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
   None.
   This stored procedure does not accept any parameters or return any values.

Usage Example:
   EXEC bronze.load_bronze;
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
    
    BEGIN TRY
        SET @batch_start_time =GETDATE();
        PRINT '===============================';
        PRINT 'Loading bronze layer ';
        PRINT '===============================';
        
        PRINT '================================';
        PRINT 'Loading CRM Tables';
        PRINT '================================';
        
        -- 1. Table: crm_cust_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Inserting Table : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\Administrator\Desktop\DAATA\cust_info.csv'
        WITH (
             FIRSTROW = 2,
             FIELDTERMINATOR = ',',
             TABLOCK
        );
        SELECT COUNT(*) FROM bronze.crm_cust_info;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds';
        
        -- 2. Table: crm_prd_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>> Inserting Table : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Administrator\Desktop\DAATA\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
         );
         SELECT COUNT(*) FROM bronze.crm_prd_info;
         SET @end_time = GETDATE();
         PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds';

         -- 3. Table: crm_sales_details (ADDED TIMERS)
         SET @start_time = GETDATE();
         PRINT '>> Truncating Table: bronze.crm_sales_details';
         TRUNCATE TABLE bronze.crm_sales_details;
         PRINT '>> Inserting Table : bronze.crm_sales_details';
         BULK INSERT bronze.crm_sales_details
         FROM 'C:\Users\Administrator\Desktop\DAATA\sales_details.csv'
         WITH (
              FIRSTROW = 2,
              FIELDTERMINATOR = ',',
              TABLOCK
          );
          SELECT COUNT(*) FROM bronze.crm_sales_details;
          SET @end_time = GETDATE();
          PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds';
          
          PRINT '================================';
          PRINT 'Loading ERP Tables';
          PRINT '================================';
          
          -- 4. Table: erp_cust_az12 (ADDED TIMERS)
          SET @start_time = GETDATE();
          PRINT '>> Truncating Table: bronze.erp_cust_az12';
          TRUNCATE TABLE bronze.erp_cust_az12;
          PRINT '>> Inserting Table : bronze.erp_cust_az12';
          BULK INSERT bronze.erp_cust_az12
          FROM 'C:\Users\Administrator\Desktop\DAATA\source_erp\CUST_AZ12.csv'
          WITH (
               FIRSTROW = 2,
               FIELDTERMINATOR = ',',
               TABLOCK
          );
          SELECT COUNT(*) FROM bronze.erp_cust_az12;
          SET @end_time = GETDATE();
          PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds';
          
          -- 5. Table: erp_loc_a101 (ADDED TIMERS)
          SET @start_time = GETDATE();
          PRINT '>> Truncating Table: bronze.erp_loc_a101';
          TRUNCATE TABLE bronze.erp_loc_a101;
          PRINT '>> Inserting Table : bronze.erp_loc_a101';
          BULK INSERT bronze.erp_loc_a101
          FROM 'C:\Users\Administrator\Desktop\DAATA\source_erp\LOC_A101.csv'
          WITH (
               FIRSTROW = 2,
               FIELDTERMINATOR = ',',
               TABLOCK
          );
          SELECT COUNT(*) FROM bronze.erp_loc_a101;
          SET @end_time = GETDATE();
          PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds';
          
          -- 6. Table: erp_px_cat_g1v2 (ADDED TIMERS)
          SET @start_time = GETDATE();
          PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
          TRUNCATE TABLE bronze.erp_px_cat_g1v2;
          PRINT '>> Inserting Table : bronze.erp_px_cat_g1v2';
          BULK INSERT bronze.erp_px_cat_g1v2
          FROM 'C:\Users\Administrator\Desktop\DAATA\source_erp\PX_CAT_G1V2.csv'
          WITH (
               FIRSTROW = 2,
               FIELDTERMINATOR = ',',
               TABLOCK
          );
          SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
          SET @end_time = GETDATE();
          PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + ' seconds';
          SET @batch_end_time = GETDATE();
           PRINT '>> Total batch Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR(50)) + ' seconds';
   END TRY
   BEGIN CATCH 
        -- Cleaned up names and fixed the NVARCHAR conversion lengths here:
        PRINT '==================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT '==================================================';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number:  ' + CAST(ERROR_NUMBER() AS NVARCHAR(50));
        PRINT 'Error State:   ' + CAST(ERROR_STATE() AS NVARCHAR(50));
        PRINT 'Error Line:    ' + CAST(ERROR_LINE() AS NVARCHAR(50));
   END CATCH
END;
GO
