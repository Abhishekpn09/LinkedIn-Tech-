-- Step 1: Create a temporary table to hold the job offer IDs and skill names
CREATE TABLE #TempJobSkills (
    job_offer_id INT,
    skill_name VARCHAR(255)
);

-- Step 2: Declare variables for dynamic SQL
DECLARE @sql NVARCHAR(MAX) = '';
DECLARE @columnName NVARCHAR(255);

-- Step 3: Declare a cursor to iterate through the skill columns
DECLARE skill_cursor CURSOR FOR
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'raw'
  AND DATA_TYPE = 'bit';

-- Step 4: Open the cursor
OPEN skill_cursor;

-- Step 5: Fetch the first column name
FETCH NEXT FROM skill_cursor INTO @columnName;

-- Step 6: Loop through all the bit columns
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Extract the skill name from the column name
    DECLARE @skillName NVARCHAR(255) = REPLACE(@columnName, 'skill_', '');

    SET @sql = @sql + 
    ' INSERT INTO #TempJobSkills (job_offer_id, skill_name)
      SELECT raw_id, ''' + @skillName + ''' 
      FROM raw
      WHERE ' + QUOTENAME(@columnName) + ' = 1;
      ';

    -- Fetch the next column name
    FETCH NEXT FROM skill_cursor INTO @columnName;
END

-- Step 7: Close and deallocate the cursor
CLOSE skill_cursor;
DEALLOCATE skill_cursor;

-- Optional: Print the generated SQL for debugging
-- PRINT @sql;

-- Step 8: Execute the dynamically generated SQL
IF LEN(@sql) > 0
BEGIN
    -- Remove the trailing semicolon if exists
    IF RIGHT(@sql, 1) = ';'
    BEGIN
        SET @sql = LEFT(@sql, LEN(@sql) - 1);
    END
    
    -- Execute the dynamic SQL
    EXEC sp_executesql @sql;

    -- Step 9: Insert data into the Job_Postings_Skills table by joining with the Skills table
    INSERT INTO Job_Postings_Skills (Job_Posting_ID, skill_id)
    SELECT t.job_offer_id, s.skill_id
    FROM #TempJobSkills t
    JOIN Skills s ON t.skill_name = s.skill;
END

-- Step 10: Drop the temporary table
DROP TABLE #TempJobSkills;
