-- Combine 2 table, only combine matched case
SELECT *
FROM "sea_lions"
JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
-- Left join, prioritizes the data in the left (or first) table some row could be partially blank
SELECT *
FROM "sea_lions"
LEFT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
-- Right join, same as lef join
SELECT *
FROM "sea_lions"
RIGHT JOIN "migrations" ON "migrations"."id" = "sea_lions"."id";
-- Automatic catch the same column attribute. "id" for this case 
SELECT *
FROM "sea_lions"
NATURAL JOIN "migrations";
