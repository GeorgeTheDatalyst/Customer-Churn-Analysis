------------------------------------
-- > Raw data extraction
------------------------------------
BULK INSERT bank_churn
FROM 'C:\Users\User\Desktop\customer churn\Bank Customer Churn Prediction.csv'
WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
);
