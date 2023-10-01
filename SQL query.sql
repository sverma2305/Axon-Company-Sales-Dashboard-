-- 1. Yearly Revenue:
SELECT YEAR(orderDate) AS Year, SUM(quantityOrdered * priceEach) AS YearlyRevenue
FROM Orders JOIN OrderDetails ON Orders.orderNumber = OrderDetails.orderNumber GROUP BY Year
ORDER BY Year;

-- 2. Top-Selling Products:
SELECT productName, SUM(quantityOrdered) AS TotalQuantityOrdered FROM OrderDetails JOIN Products
ON OrderDetails.productCode = Products.productCode GROUP BY productName
ORDER BY TotalQuantityOrdered DESC
LIMIT 10;

-- 3. Sales Growth Rate:
SELECT *FROM sales_growth_rate;
	CREATE TABLE sales_growth_rate AS SELECT
		o.Year,
		SUM(od.quantityOrdered * od.priceEach) AS YearlyRevenue,
		ROUND((SUM(od.quantityOrdered * od.priceEach) - YearlyRevenuePrev) / YearlyRevenuePrev * 100, 2) AS GrowthRate
	FROM
		(SELECT
			YEAR(orderDate) AS Year,
			orderNumber
		FROM
			Orders) o
	JOIN
		OrderDetails od
	ON
		o.orderNumber = od.orderNumber
	LEFT JOIN
		(SELECT
			YEAR(orderDate) AS Year,
			SUM(quantityOrdered * priceEach) AS YearlyRevenuePrev
		FROM
			Orders
		JOIN
			OrderDetails
		ON
			Orders.orderNumber = OrderDetails.orderNumber
		GROUP BY
			Year) PreviousYearlySales
	ON
		o.Year = PreviousYearlySales.Year + 1
	GROUP BY
		o.Year, YearlyRevenuePrev
	ORDER BY
		o.Year;
        
-- using self join for creating table to display emp name and manager name
CREATE TABLE emp_manager AS
SELECT 
    e.employeeNumber AS emp_num,
    CONCAT(e.firstName, ' ', e.lastName) AS Employee,
    m.employeeNumber AS m_num,
    CONCAT(m.firstName, ' ', m.lastName) AS ReportsTo
FROM 
    Employees e
LEFT JOIN 
    Employees m ON e.ReportsTo = m.employeeNumber;

SELECT *FROM emp_manager;
  
