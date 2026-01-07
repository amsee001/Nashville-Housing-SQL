SELECT *
FROM nashville_housing_cleaned;

-- Count records and unique parcels
SELECT 
    COUNT(*) AS TotalRecords,
    COUNT(DISTINCT ParcelID) AS UniqueParcels
FROM nashville_housing_cleaned;

-- Average SalePrice and TotalSales by Year
-- Tableau Data
SELECT
	YEAR(SaleDate) AS SaleYear,
    COUNT(*) AS SalesCount,
    AVG(SalePrice) AS AvgPrice,
    SUM(SalePrice) AS TotalSales
FROM nashville_housing_cleaned
WHERE SalePrice 
GROUP BY SaleYear
ORDER BY SaleYear;

-- Average price by LandUse
-- Tableau Data
SELECT 
    LandUse,
    AVG(SalePrice) AS AvgPrice,
    COUNT(*) AS NumSales
FROM nashville_housing_cleaned
GROUP BY LandUse
ORDER BY AvgPrice DESC;

-- SalesPrice vs AssessedPrice
-- Tableau Data
SELECT 
	UniqueID,
    ParcelID,
    PropertyAddress,
    PropertyCity,
    SalePrice,
    TotalValue,
    (SalePrice - TotalValue) AS AssessedPrice
FROM nashville_housing_cleaned
WHERE TotalValue > 0
ORDER BY AssessedPrice DESC;

-- Bedrooms and Bathrooms in relation to AvgPrice
-- Tableau Data
SELECT
    Bedrooms,
    FullBath,
    HalfBath,
    AVG(SalePrice) AS AvgPrice
FROM nashville_housing_cleaned
WHERE Bedrooms > 0
	AND FullBath > 0
GROUP BY Bedrooms, FullBath, HalfBath
ORDER BY Bedrooms, FullBath, HalfBath;

-- Price per Acreage
-- Tableau Data
SELECT
	UniqueID,
    ParcelID,
    SalePrice,
    Acreage,
    ROUND(SalePrice / Acreage) AS PricePerAcre
FROM nashville_housing_cleaned
WHERE Acreage > 0
ORDER BY Acreage;

-- Owners with multiple properties
-- Tableau Data
SELECT 
	LandUse,
    OwnerName,
    COUNT(*) AS PropertiesOwned
FROM nashville_housing_cleaned
WHERE OwnerName IS NOT NULL
GROUP BY OwnerName, LandUse
HAVING COUNT(*) > 1
ORDER BY PropertiesOwned DESC, OwnerName;