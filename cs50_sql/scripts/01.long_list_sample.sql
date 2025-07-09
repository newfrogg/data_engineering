-- INTERSECT rule
SELECT "name" FROM "translators"
INTERSECT
SELECT "name" FROM "authors";
-- UNION rule
SELECT "name" FROM "translators"
UNION
SELECT "name" FROM "authors";
-- This minor change reveal the profession (author or translator) of this person.
SELECT 'author' AS "profession", "name" 
FROM "authors"
UNION
SELECT 'translator' AS "profession", "name" 
FROM "translators";
-- EXCEPT rule: authors only is OK (translators is removed)
SELECT "name" FROM "authors"
EXCEPT
SELECT "name" FROM "translators";
-- find the book that Sophie and Margaret translated together
SELECT "book_id" FROM "translated"
WHERE "translator_id" = (
	SELECT "id" from "translators"
    WHERE "name" = 'Sophie Hughes'
)
INTERSECT
SELECT "book_id" FROM "translated"
WHERE "translator_id" = (
    SELECT "id" from "translators"
    WHERE "name" = 'Margaret Jull Costa'
);
-- to find avg rating of the book but first group by book_id
SELECT "book_id", AVG("rating") AS "average rating"
FROM "ratings"
GROUP BY "book_id";
-- get the rating  > 4 only
SELECT "book_id", ROUND(AVG("rating"),2) AS "average rating"
FROM "ratings"
GROUP BY "book_id"
HAVING "average rating" >= 4.0;
-- to see the number of rating for each book
SELECT "book_id" AS "#book", COUNT("rating") AS "#ratings"
FROM "ratings"
GROUP BY "book_id";
-- to sort data by roting descending way
SELECT "book_id" as "#book", ROUND(AVG("rating"),2) AS "average rating"
FROM "ratings"
GROUP BY "book_id"
HAVING "average rating" >= 4.0
ORDER BY "average rating" DESC;