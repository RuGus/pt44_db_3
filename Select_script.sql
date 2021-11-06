SELECT name, year
FROM albums
WHERE year = 2018;

SELECT name, duration
FROM tracks
WHERE duration = (SELECT MAX(duration) FROM tracks);

SELECT name
FROM tracks
WHERE duration >= 210;

SELECT name
FROM collections
WHERE year >= 2018 AND year <= 2020;

SELECT name
FROM singers
WHERE name not like '% %';

SELECT name
FROM tracks
WHERE name ILIKE '%my%' OR name ILIKE '%мой%';