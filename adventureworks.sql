use AdventureWorks2022
select*from HumanResources.Department
select*from HumanResources.Employee
select*from HumanResources.EmployeeDepartmentHistory
select*from HumanResources.EmployeePayHistory
select*from HumanResources.JobCandidate
select*from HumanResources.Shift

SELECT BusinessEntityID ,
        MIN(HireDate) ,
        MAX(HireDate)
FROM     HumanResources.Employee
GROUP BY BusinessEntityID;

SELECT  COUNT(0) NumberOfEmployees ,
        COUNT(DISTINCT BusinessEntityID) NumberOfDepartments
FROM    HumanResources.Employee;
------------------------------
select*from Person.Address
select*from Person.AddressType
select*from Person.BusinessEntity
select*from Person.BusinessEntityAddress
select*from Person.BusinessEntityContact
select*from Person.ContactType
select*from Person.CountryRegion
select*from Person.EmailAddress
select*from Person.Password
select*from Person.Person
select*from Person.PersonPhone
select*from Person.PhoneNumberType
select*from Person.StateProvince
---------------------------------------
select*from Production.BillOfMaterials
select*from Production.Culture
select*from Production.Document
select*from Production.Illustration
select*from Production.Location
select*from Production.Product
select*from Production.ProductCategory
select*from Production.ProductCostHistory
select*from Production.ProductDescription
select*from Production.ProductDocument
select*from Production.ProductInventory
select*from Production.ProductListPriceHistory
select*from Production.ProductModel
select*from Production.ProductModelIllustration
select*from Production.ProductModelProductDescriptionCulture
select*from Production.ProductPhoto
select*from Production.ProductProductPhoto
select*from Production.ProductReview
select*from Production.ProductSubcategory
select*from Production.ScrapReason
select*from Production.TransactionHistory
select*from Production.TransactionHistoryArchive
select*from Production.UnitMeasure
select*from Production.WorkOrder
select*from Production.WorkOrderRouting

--------------------------------
select*from Purchasing.ProductVendor
select*from Purchasing.PurchaseOrderDetail
select*from Purchasing.PurchaseOrderHeader
select*from Purchasing.ShipMethod
select*from Purchasing.Vendor
----------------------------------
select*from Sales.CountryRegionCurrency
select*from Sales.CreditCard
select*from Sales.Currency
select*from Sales.CurrencyRate
select*from Sales.Customer
select*from Sales.PersonCreditCard
select*from Sales.SalesOrderDetail
select*from Sales.SalesOrderHeader
select*from Sales.SalesOrderHeaderSalesReason
select*from Sales.SalesPerson
select*from Sales.SalesPersonQuotaHistory
select*from Sales.SalesReason
select*from Sales.SalesTaxRate
select*from Sales.SalesTerritory
select*from Sales.SalesTerritoryHistory
select*from Sales.ShoppingCartItem
select*from Sales.SpecialOffer
select*from Sales.SpecialOfferProduct
select*from Sales.Store

SELECT  (CASE OrderSummary.OrderDate
              WHEN 1 THEN ( OrderSummary.OrderTotal )
              ELSE 0
            END) AS JanuaryOrders ,
        (CASE OrderSummary.OrderDate
              WHEN 2 THEN ( OrderSummary.OrderTotal )
              ELSE 0
            END) AS FeburaryOrders ,
        (CASE OrderSummary.OrderDate
              WHEN 3 THEN ( OrderSummary.OrderTotal )
              ELSE 0
            END) AS MarchOrders
FROM    ( SELECT    DATEPART(MONTH, SalesOrderHeader.OrderDate) AS OrderDate ,
                    min(TotalDue) AS OrderTotal
          FROM      Sales.SalesOrderHeader
          GROUP BY  DATEPART(MONTH, OrderDate) ) OrderSummary;


----duplicidad de clientes----
SELECT CustomerId, COUNT(1) as CustomerCount
FROM SALES.Customer
GROUP BY CustomerId
ORDER BY CustomerCount DESC;
---contar cuantos clientes han hecho ordenes o compras
SELECT CustomerId, COUNT(SalesOrderID) as OrderCount
FROM SALES.SalesOrderHeader
GROUP BY CustomerId
HAVING COUNT(SalesOrderID) > 1 --1 hasta 27--

SELECT c.CustomerId,  o.OrderCount, p.Name,so.ProductID, s.OrderDate
FROM SALES.Customer c
INNER JOIN (
    SELECT CustomerId, COUNT(SalesOrderID) as OrderCount
    FROM SALES.SalesOrderHeader
    GROUP BY CustomerId
    HAVING COUNT(SalesOrderID) > 1
) o ON c.CustomerId = o.CustomerId 
inner join Sales.SalesOrderHeader s on c.CustomerID = s.CustomerID
inner join sales.SalesOrderDetail so on s.SalesOrderID=so.SalesOrderID
inner join Production.Product p on p.ProductID=so.ProductID