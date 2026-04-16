
create or alter procedure bronze.load_bronze as
BEGIN
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	BEGIN TRY

		set @batch_start_time = GETDATE()
		print '================================================================';
		PRINT 'Loading Bronze Layer';
		print '================================================================';


		print '----------------------------------------------------------------'
		print 'Loading CRM files'
		print '----------------------------------------------------------------'

		set @start_time = getdate()
		TRUNCATE TABLE bronze.crm_cust_info
		bulk insert bronze.crm_cust_info
		from 'C:\Users\andjela.pejovic\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate()
		print'>> Load Duration:: ' +cast( datediff(second,@start_time,@end_time) as nvarchar)+  ' seconds'
		print'------------------------------------------------------------------------------------------'

		set @start_time = getdate()
		TRUNCATE TABLE bronze.crm_prd_file
		bulk insert bronze.crm_prd_file
		from 'C:\Users\andjela.pejovic\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate()
		print'>> Load Duration:: ' +cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print'------------------------------------------------------------------------------------------'

		set @start_time = getdate()
		TRUNCATE TABLE bronze.crm_sales_details
		bulk insert bronze.crm_sales_details
		from 'C:\Users\andjela.pejovic\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print'>> Load Duration:: ' +cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print'------------------------------------------------------------------------------------------'

		print '----------------------------------------------------------------'
		print 'Loading ERP files'
		print '----------------------------------------------------------------'

		set @start_time = getdate()
		TRUNCATE TABLE bronze.erp_cust_az12
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\andjela.pejovic\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print'>> Load Duration:: ' +cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print'------------------------------------------------------------------------------------------'

		set @start_time = getdate()
		TRUNCATE TABLE bronze.erp_loc_a101
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\andjela.pejovic\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		print'>> Load Duration:: ' +cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print'------------------------------------------------------------------------------------------'


		set @start_time = getdate()
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\andjela.pejovic\Desktop\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE()
		print'>> Load Duration:: ' +cast( datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
		print'------------------------------------------------------------------------------------------'

		set @batch_end_time = GETDATE()
		print '=================================================='
		print 'Loading Bronze Layer is completed'
		print '	  -Total Load Duration ' + cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) +' seconds'
		print '=================================================='

	END TRY

	BEGIN CATCH

		PRINT '===================================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZR LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE()
		PRINT 'Error Number' + cast( ERROR_NUMBER() as nvarchar) 
		PRINT 'Error Number' + cast( ERROR_STATE() as nvarchar) 
		PRINT '===================================================='

		
		
	END CATCH

END
