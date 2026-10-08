This is creating the bronze layer tables 
it defines the internal structure of the bronze layer 




USE Datawarehouse;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
);
CREATE TABLE bronze.crm_prd_info(
    prd_id INT,
    prd_key NVARCHAR (50),
    prd_nm NVARCHAR (50),
    prd_cost INT,
    prd_line NVARCHAR (50),
    prd_start_dt DATETIME,
    prd_stop_dt DATETIME,
   );

