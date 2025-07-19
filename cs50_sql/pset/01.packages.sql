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
-- This means this package was served by the driver Matthew. He pick and drop at the to_address_id = 854
-- Assume that everything works truly. He sent to the address (ID: 854) not 2 Finnegan Street,
-- we can trace from the id_address to know where the lost package came to => solve the problem
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
-- Second Section
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
SELECT *
FROM "scans"
WHERE "package_id" == 5098;
--> id of package 30123, driver_id 10, timestamp 2023-10-24 08:40:16
SELECT *
FROM "drivers"
WHERE "id" == 10;
--> driver name is Josephine
-- Summary:
-- the missing package which doesn't have the from address (because the sender give it to the driver at the town of Fiftyville).
-- The driver named Josephine then scan (action: pick at adress id 50) at 08:40, 24/10/2023 and drop at address_id = 348 10:08, same day.
-- The lost delivery is Duck debugger for IT engineers. 
-- >>> Insign: [from_address_id from scans] (mean place where the driver scan of picking up) can't empty 
-- >>> while the [id in address] often same but it can be empty.
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
-- Third Section
-- *** The Forgotten Gift ***
SELECT *
FROM "addresses"
WHERE "address" LIKE "109 Tileston Street";
--> the gift sent from 109 Tileston Street have id 9873, type Residental
SELECT *
FROM "packages"
WHERE "from_address_id" == 9873;
--> the package have ID 9523, contents: Flowers with to_address_id, 4983
SELECT *
FROM "scans"
WHERE "package_id" == 9523;
--> this was pick/drop by driver with id 11 at 21:41, 16/08/2023 and 03:31, 17/08/2023 respectively. this drop at address_id 7432
-- then pick again by driver with id 17 at the address_id 7432 by 19:41, 23/08/2023, no drop action recorded.
SELECT *
FROM "drivers"
WHERE "id" == 11 OR "id" == 17;
--> Meagan scan pick, drop the package Mikel scan pick up it later.
-- Summary:
-- The customer sent the flower to her daughter though delivery service. She sent from her home at 109 Tileston Street. 
-- The destination should be 728 Maple Place. The package was scan pickup by Maegan at 21:41, 16/08/2023 and drop out at 
-- 03:31 next day at address with ID, 7432. Then 6 day later, Mikel pick up the package again. Till now, no more Dropping out actions 
-- are recorded. So we can find Mikel as solution of this problem.
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------