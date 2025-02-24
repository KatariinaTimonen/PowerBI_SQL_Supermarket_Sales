CREATE TABLE supermarket_sales(
	Invoice_ID NVARCHAR(50),
	Branch NVARCHAR(50),
	City NVARCHAR(50),
	Customer_type NVARCHAR(50),
	Gender NVARCHAR(50),
	Product_line NVARCHAR(50),
	Unit_price FLOAT,
	Quantity INT,
	Tax FLOAT,
	Total FLOAT,
	Date DATE,
	Time TIME,
	Payment NVARCHAR(50),
	cogs FLOAT,
	gross_margin_percentage FLOAT,
	gross_income FLOAT,
	Rating FLOAT
);


BULK INSERT supermarket_sales
FROM 'C:\Users\Documents\business modelling\SQL_supermarket/supermarket_sales - Sheet1.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    FIRSTROW = 2
);

SELECT * FROM supermarket_sales

-- Sum of total price of sold goods
SELECT SUM(Total) AS total_sales FROM supermarket_sales
-- 322966,749

-- Average order value
SELECT SUM(Total) / COUNT(DISTINCT Invoice_ID) AS avg_order_value FROM supermarket_sales
-- 332,966749

-- Sum of all sold goods
SELECT SUM(Quantity) AS total_sold_amount FROM supermarket_sales
-- 5510

-- Total sales per customer type
SELECT  Customer_type, SUM(Total) AS sales_customer_type FROM supermarket_sales GROUP BY Customer_type 
-- normal 158743,305 member 164223,444

-- Payment method distribution
SELECT Payment, COUNT(DISTINCT Invoice_ID) AS payment_method FROM supermarket_sales GROUP BY Payment ORDER BY payment_method DESC
-- Ewallet 345 Cash 344 Credit card 311

-- Average rating on shopping experience by customer type
SELECT Customer_type, AVG(Rating) AS rating_customer_type FROM supermarket_sales GROUP BY Customer_type
-- normal 7,00521 member 6,94032