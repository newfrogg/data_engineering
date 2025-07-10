-- Get idea of database
SELECT *
FROM "addresses";
-- First Section
-- *** The Lost Letter ***
SELECT *
FROM "addresses"
WHERE "address" == "900 Somerville Avenue";
--> ID of address == 432, type: Residental
SELECT *
FROM "packages"
WHERE "from_address_id" == "432" AND "contents" LIKE "Congratulatory%";
--> id of package == 384, to_address_id = 854
SELECT *
FROM "scans"
WHERE "package_id" == 384;
--> driver_id == 1, action:
-- pick at 19:33, 2023-07-11
-- drop at 23:07, same day
SELECT *
FROM "drivers"
WHERE "id" == 1;
--> driver name "Matthew"
-- Summary: 
-- A Congratulation letter sent from 900 Somerville Avenue by Anneke through delivery service
-- to her friend - Varsha at 2 Finnegan Street was served by a driver named Matthew. 
-- This letter was picked at 7:33 PM, 2023-07-11 and dropped at 23:07 in same day.
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- *** The Devious Delivery ***
SELECT *
FROM "addresses";
-- query to address "Fiftyville"
SELECT *
FROM "packages"
WHERE "from_address_id" IS NULL;
--> id of package 5098, content Duck debugger, to_address_id == 50
SELECT *
FROM "scans"
WHERE "package_id" == 5098;
--> pick at address_id 50, drop at 348
SELECT *
FROM "addresses"
WHERE "id" == 50;
--> address 123 Sesame Street, type Residential