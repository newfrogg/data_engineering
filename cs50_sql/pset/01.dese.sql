-- Your colleague is preparing a map of all public schools in Massachusetts. In 1.sql, 
-- write a SQL query to find the [names and cities] of all public schools in Massachusetts.
-- Keep in mind that not all schools in the schools table are considered traditional public schools. 
-- Massachusetts also recognizes charter schools, which (according to DESE!) are considered distinct.
SELECT "name", "city"
FROM "schools"
WHERE "type" LIKE "%Public%";
-- Your team is working on archiving old data. 
-- In 2.sql, write a SQL query to find the names of districts that are no longer operational.
-- Districts that are no longer operational have “(non-op)” at the end of their name.
SELECT "name", "city"
FROM "districts"
WHERE "name" LIKE "%(non-op)%";
-- The Massachusetts Legislature would like to learn how much money, 
-- on average, districts spent per-pupil last year. 
-- In 3.sql, write a SQL query to find the average per-pupil expenditure. 
-- Name the column “Average District Per-Pupil Expenditure”.
-- Note the per_pupil_expenditure column in the expenditures table contains 
-- the average amount, per pupil, each district spent last year. 
-- You’ve been asked to find the average of this set of averages, 
-- weighting all districts equally regardless of their size.
SELECT ROUND(AVG("per_pupil_expenditure"), 2) AS "Average District Per-Pupil Expenditure"
FROM "expenditures";
-- Some cities have more public schools than others. 
-- In 4.sql, write a SQL query to find the 10 cities with the most public schools. 
-- Your query should return the names of the cities and the number of public schools 
-- within them, ordered from greatest number of public schools to least. 
-- If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT(*) AS "public_schools"
FROM "schools"
WHERE "type" LIKE "Public%"
GROUP BY "city"
ORDER BY "public_schools" DESC
LIMIT 10;
-- DESE would like you to determine in what cities additional public schools might be needed. 
-- In 5.sql, write a SQL query to find cities with 3 or fewer public schools. 
-- Your query should return the names of the cities and the number of public schools within them, 
-- ordered from greatest number of public schools to least. 
-- If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT(*) AS "public_schools"
FROM "schools"
WHERE "type" LIKE "Public%"
GROUP BY "city"
HAVING "public_schools" <= 3
ORDER BY "public_schools" DESC, "city" ASC;
-- DESE wants to assess which schools achieved a 100% graduation rate. 
-- In 6.sql, write a SQL query to find the names of schools 
-- (public or charter!) that reported a 100% graduation rate.
SELECT "name", "id"
FROM "schools"
WHERE "id" IN (
	SELECT "school_id"
	FROM "graduation_rates"
	WHERE "graduated" = 100
);
--> to get query a list we should use IN instead of ==
-- DESE is preparing a report on schools in the Cambridge school district. 
-- In 7.sql, write a SQL query to find the names of schools (public or charter!) 
-- in the Cambridge school district. 
-- Keep in mind that Cambridge, the city, contains a few school districts, 
-- but DESE is interested in the district whose name is “Cambridge.”
SELECT *
FROM "districts"
WHERE "city" == "Cambridge" AND "name" == "Cambridge";
-- >> we don't count of public or charter but we count base on the name of disctric school "Cambridge"
-- >> for this case it also Public School.
SELECT *
FROM "schools"
WHERE "district_id" IN (
	SELECT "id"
	FROM "districts"
	WHERE "city" == "Cambridge" AND "name" == "Cambridge"
);
-- A parent wants to send their child to a district with many other students.
-- In 8.sql, write a SQL query to display the names of all school districts 
-- and the number of pupils enrolled in each.
SELECT *
FROM "districts";
-- >> we can also left join to leave some row partially empty. By looking
-- >> at data, the schools named non-op don't containt information about number of pupils.
SELECT "name", "pupils"
FROM "districts"
JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id";
-- Case 1: NOT (non-op) => 399 rows
-- SELECT "name", "pupils"
-- FROM "districts"
-- LEFT JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id"
-- WHERE "name" NOT LIKE "%(non-op)%";
-- Case 2: NOT NULL => 396 rows, same to official way (JOIN only, no need caring missing data)
-- SELECT "name", "pupils"
-- FROM "districts"
-- LEFT JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id"
-- WHERE "pupils" IS NOT NULL;
-- Another parent wants to send their child to a district with few other students. 
-- >> when we apply left join and filter (non-op) only we get 399 results. By checking by hand,
-- >> we find that 3 schools don't have information abouth pupils. Maybe they have just built and 
-- >> don't have the record at this time.

-- In 9.sql, write a SQL query to find the name (or names) of the school district(s) 
-- with the single least number of pupils. Report only the name(s).
-- Way 1: Combine to table then sort ascending, get the first
SELECT "name", "pupils"
FROM "districts"
JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id"
ORDER BY "pupils" ASC
LIMIT 1;
-- Way 2: Using subquery to get the min value and then find the school name repectively
SELECT "name", "pupils"
FROM "districts"
JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id"
WHERE "pupils" == (
	SELECT MIN("pupils")
	FROM "districts"
	JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id"
);
-- In Massachusetts, school district expenditures are in part determined 
-- by local taxes on property (e.g., home) values. 
-- In 10.sql, write a SQL query to find the 10 public school districts 
-- with the highest per-pupil expenditures. 
-- Your query should return the names of the 
-- districts and the per-pupil expenditure for each.
SELECT "name", "per_pupil_expenditure"
FROM "districts"
JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id"
ORDER BY "per_pupil_expenditure" DESC
LIMIT 10;
-- Is there a relationship between school expenditures and graduation rates? 
-- In 11.sql, write a SQL query to display the names of schools, 
-- their per-pupil expenditure, and their graduation rate. 
-- Sort the schools from greatest per-pupil expenditure to least. 
-- If two schools have the same per-pupil expenditure, sort by school name.
-- You should assume a school spends the same amount per-pupil their district as a whole spends.
-- SELECT *
SELECT "schools"."name", "expenditures"."per_pupil_expenditure", "graduation_rates"."graduated"
FROM "graduation_rates"
JOIN "schools" ON "schools"."id" == "graduation_rates"."school_id"
JOIN "districts" ON "districts"."id" == "schools"."district_id"
JOIN "expenditures" ON "expenditures"."district_id" == "districts"."id"
ORDER BY "expenditures"."per_pupil_expenditure" DESC, "schools"."name" ASC;
-- A parent asks you for advice on finding the best [public school districts] in Massachusetts. 
-- In 12.sql, write a SQL query to find public school districts 
-- with above-average per-pupil expenditures and an above-average percentage 
-- of teachers rated “exemplary”. 
-- Your query should return the districts’ names, 
-- along with their per-pupil expenditures and percentage of teachers rated exemplary. 
-- Sort the results first by the percentage of teachers rated exemplary (high to low), 
-- then by the per-pupil expenditure (high to low).

-- The avg of per_pupil_expenditure
SELECT AVG("per_pupil_expenditure")
FROM "expenditures";
-- The avg of exemplary
SELECT AVG("exemplary")
FROM "staff_evaluations";
-- Note that only public schools is queried
SELECT "districts"."name", "expenditures"."per_pupil_expenditure", "staff_evaluations"."exemplary"
FROM "districts"
JOIN "staff_evaluations" ON "districts"."id" == "staff_evaluations"."district_id"
JOIN "expenditures" ON "districts"."id" == "expenditures"."district_id"
WHERE "districts"."type" == "Public School District"
AND "expenditures"."per_pupil_expenditure" >= (
	SELECT AVG("per_pupil_expenditure")
	FROM "expenditures"
)
AND "staff_evaluations"."exemplary" >= (
	SELECT AVG("exemplary")
	FROM "staff_evaluations"
)
ORDER BY 
"staff_evaluations"."exemplary" DESC, 
"expenditures"."per_pupil_expenditure" DESC
;