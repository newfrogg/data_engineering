---------------------------------------
--- Mounted database: long_list.db ----
--- select all rows of loaded .db -----
-------------------
-- SELECT Basics --
-------------------
SELECT *
FROM longlist;
-- select row named title and author with limit the output query to first 12 row
SELECT "title", "author"
FROM longlist
LIMIT 12;
-- select with condition #pages equal to 200
SELECT "author", "title", "pages"
FROM "longlist"
WHERE "pages" = 200;
-- select with condition format not equal to paperback
SELECT "format"
FROM "longlist"
WHERE "format" != 'paperback';
-- symbol != can be replaced by <>
SELECT "format"
FROM "longlist"
WHERE "format" <> 'paperback';
-- or WHERE NOT. Below example as j4f =))
SELECT "format"
FROM "longlist"
WHERE NOT "format" <> 'paperback';
-- to combine condition
SELECT "title", "year", "format" 
FROM "longlist" 
WHERE ("year" = 2022 OR "year" = 2023) AND "format" != 'hardcover';
----------
-- NULL --
---------- 
-- select book 'translator don't exist  (b/c some books haven't been translated into English.
SELECT "title", "translator" 
FROM "longlist"
WHERE "translator" IS NULL;
-- try reverse case
SELECT "title", "translator" 
FROM "longlist"
WHERE "translator" IS NOT NULL
LIMIT 2;
----------
-- LIKE --
---------- 
-- % match for 0 or more characters
-- to select books with love in their titles (case insensitive)
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%love%';
-- match start with love 
SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'love%';
-- match end with love
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%love';
-- match any single charact internal by b and g. Ex: bad, big, Baghdad, building, Blinding 
SELECT "title" 
FROM "longlist" 
WHERE "title" LIKE '%b%g%';
-- match any single charact internal by b and g to become a word. Ex: bad, big, Baghdad
SELECT "title" 
FROM "longlist" 
WHERE "title" LIKE '%b_g%';
-- match word start by T combine 3 random single-character
SELECT "title" 
FROM "longlist" 
WHERE "title" LIKE 'T___';
-----------
-- RANGE --
----------- 
-- to select books with #paper >= 500 and @rating >= 4.0 and votes >= 1000 (more confident voting result) 
-- in the @year of 2023
SELECT "title", "author", "pages", "rating", "year", "votes"
FROM "longlist"
WHERE "pages" >= 200 AND "rating" >= 4.0 AND "year" == 2023 AND "votes" >= 1000 ;
--------------
-- ORDER BY --
-------------- 
-- get the bottom 10 books because ORDER BY chooses ascending order by default.
SELECT "title", "rating" 
FROM "longlist" 
ORDER BY "rating" 
LIMIT 15;
-- desc case
SELECT "title", "rating" 
FROM "longlist" 
ORDER BY "rating" DESC 
LIMIT 15;
-- to select the top 10 books with least rating with voting >= 1000
SELECT "title", "rating", "votes" 
FROM "longlist" 
WHERE "votes" >= 1000
ORDER BY "rating" ASC
LIMIT 10;
-- to select the top 10 best books by rating with voting < 1000
SELECT "title", "rating", "votes" 
FROM "longlist" 
WHERE "votes" < 1000
ORDER BY "rating" DESC
LIMIT 10;
-- to sort book title by alphabetic
SELECT "title" 
FROM "longlist" 
ORDER BY "title";
------------------------
-- AGGREGATE FUNCTION --
------------------------
-- COUNT, AVG, MIN, MAX, and SUM are called aggregate functions and 
-- allow us to perform the corresponding operations over multiple rows of data.
-- AVG
SELECT AVG("rating") 
FROM "longlist";
-- COUNT
SELECT COUNT("rating") 
FROM "longlist";
-- MIN
SELECT MIN("rating") 
FROM "longlist";
-- MAX
SELECT MAX("rating") 
FROM "longlist"; 
-- to rename dump ROW
SELECT ROUND(AVG("rating"), 2) AS "average rating" 
FROM "longlist";
-- Total number of votes are recorded
SELECT SUM("votes") 
FROM "longlist";
-- count translator = 76
SELECT COUNT("translator") 
FROM "longlist";
-- count total of books = 78
-- this means: only 76 books in this record are translated into English
SELECT COUNT(*) 
FROM "longlist";
-- count number of publisher
-- this query will count the number of publisher values that are not NULL. 
-- However, this may include duplicates. 
SELECT COUNT("publisher") 
FROM "longlist";
-- add on DISTINCT to make value uniquely
SELECT COUNT(DISTINCT("publisher")) as "total_publishers"
FROM "longlist";
