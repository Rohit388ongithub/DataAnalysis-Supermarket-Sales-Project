/*SELECT "Category","Region",SUM("Sales") AS total_sales
FROM "clean_sales"
GROUP BY "Category","Region"
ORDER BY total_sales DESC;*/

/*SELECT "City",SUM("Sales") AS total_sales,
ROW_NUMBER() OVER(ORDER BY SUM("Sales")DESC) AS Sales_rank
FROM "clean_sales"
GROUP BY "City"
ORDER BY total_sales DESC;*/

/*SELECT "City",
		"Region"
		total_sales,
		ROW_NUMBER() OVER (PARTITION BY "Region" ORDER BY total_sales DESC) AS city_rank
FROM(
	SELECT "City","Region", SUM("Sales") AS total_sales
	FROM "clean_sales"
	GROUP BY "City","Region"
) AS city_sales
ORDER BY "Region",city_rank;*/

/*WITH total_sales_per_city AS(
	SELECT "City",SUM("Sales") AS total_sales
	FROM "clean_sales"
	GROUP BY "City"
)
SELECT "City",total_sales
FROM total_sales_per_city
ORDER BY total_sales DESC
LIMIT 5;*/

-- Step 1: Create Segments Table
/*CREATE TABLE Segments (
    Segment_ID SERIAL PRIMARY KEY,
    Segment_Name VARCHAR(100) UNIQUE
);

-- Insert distinct segments into Segments table
INSERT INTO Segments (Segment_Name)
SELECT DISTINCT "Segment"
FROM "clean_sales"
ON CONFLICT (Segment_Name) DO NOTHING;  -- Skip if already exists

-- Step 2: Create Regions Table
CREATE TABLE Regions (
    Region_ID SERIAL PRIMARY KEY,
    City VARCHAR(100),
    Region VARCHAR(100),
    UNIQUE (City, Region)  -- Ensure uniqueness on City and Region
);

-- Insert distinct city and region pairs into Regions table
INSERT INTO Regions (City, Region)
SELECT DISTINCT "City", "Region"
FROM "clean_sales"
ON CONFLICT (City, Region) DO NOTHING;  -- Skip if already exists

-- Step 3: Create Sales Table
CREATE TABLE Sales (
    Order_ID VARCHAR(100) PRIMARY KEY,
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(100),
    Segment_ID INT,
    Region_ID INT,
    Sales DECIMAL(10, 2),
    FOREIGN KEY (Segment_ID) REFERENCES Segments(Segment_ID),
    FOREIGN KEY (Region_ID) REFERENCES Regions(Region_ID)
);

-- Insert data into the Sales table by joining the Segments and Regions tables
INSERT INTO Sales (Order_ID, Order_Date, Ship_Date, Ship_Mode, Segment_ID, Region_ID, Sales)
SELECT 
    cs."Order_ID",
    MIN(cs."Order_Date") AS Order_Date,  -- Use MIN or MAX depending on your logic
    MIN(cs."Ship_Date") AS Ship_Date,     -- Use MIN or MAX depending on your logic
    MIN(cs."Ship_Mode") AS Ship_Mode,     -- Use MIN or MAX depending on your logic
    s.Segment_ID,
    r.Region_ID,
    SUM(cs."Sales") AS Total_Sales
FROM "clean_sales" cs
JOIN Segments s ON cs."Segment" = s.Segment_Name
JOIN Regions r ON cs."City" = r.City AND cs."Region" = r.Region
GROUP BY cs."Order_ID", s.Segment_ID, r.Region_ID
ON CONFLICT (Order_ID) DO NOTHING;  -- Skip if Order_ID already exists*/
-- Check data in Segments table
/*SELECT * FROM Segments;

-- Check data in Regions table
SELECT * FROM Regions;

-- Check data in Sales table
SELECT * FROM Sales;*/








		
		

