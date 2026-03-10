/* Step 1: Use the correct database */
USE RetailDataWarehouse;
GO

/* Step 2: Drop table if it exists */
IF OBJECT_ID('[RetailDataWarehouse].dbo.DimDate', 'U') IS NOT NULL
DROP TABLE [RetailDataWarehouse].dbo.DimDate;
GO

/* Step 3: Create DimDate table */
CREATE TABLE [RetailDataWarehouse].dbo.DimDate
(
    DateKey INT NOT NULL PRIMARY KEY,
    FullDate DATE NOT NULL,
    MonthID INT NOT NULL,
    MonthInYear INT NOT NULL,
    QuarterID INT NOT NULL,
    QuarterInYear INT NOT NULL,
    [Year] INT NOT NULL,
    WeekInYear INT NOT NULL,
    DayInYear INT NOT NULL,
    DayInMonth INT NOT NULL,
    DayInWeek INT NOT NULL,
    IsWeekend BIT NOT NULL,
    IsWorkDay BIT NOT NULL,
    IsPublicHoliday BIT NOT NULL,
    ReportingDateDesc VARCHAR(12) NULL
);
GO


/* Step 4: Insert dates */
DECLARE @StartDate DATE = '2025-01-01';
DECLARE @EndDate DATE   = '2025-12-31';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO dbo.DimDate
    (
        DateKey,
        FullDate,
        MonthID,
        MonthInYear,
        QuarterID,
        QuarterInYear,
        [Year],
        WeekInYear,
        DayInYear,
        DayInMonth,
        DayInWeek,
        IsWeekend,
        IsWorkDay,
        IsPublicHoliday,
        ReportingDateDesc
    )
    SELECT
        CONVERT(INT, FORMAT(@StartDate,'yyyyMMdd')),       
        @StartDate,                                        
        CONVERT(INT, FORMAT(@StartDate,'yyyyMM')),         
        MONTH(@StartDate),                                 
        YEAR(@StartDate)*10 + DATEPART(QUARTER,@StartDate),
        DATEPART(QUARTER,@StartDate),                      
        YEAR(@StartDate),                                  
        DATEPART(WEEK,@StartDate),                         
        DATEPART(DAYOFYEAR,@StartDate),                    
        DAY(@StartDate),                                   
        DATEPART(WEEKDAY,@StartDate),                      
        CASE WHEN DATEPART(WEEKDAY,@StartDate) IN (1,7) THEN 1 ELSE 0 END,
        CASE WHEN DATEPART(WEEKDAY,@StartDate) IN (1,7) THEN 0 ELSE 1 END,
        0,
        FORMAT(@StartDate,'MMM yyyy');

    SET @StartDate = DATEADD(DAY,1,@StartDate);

END;
GO


/* Step 5: Check results */
SELECT *
FROM dbo.DimDate
ORDER BY FullDate;