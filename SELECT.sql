SELECT  name,YEAR FROM albums WHERE YEAR = 2018;

SELECT name, duration FROM tracks WHERE duration = (SELECT max(duration) FROM tracks);

SELECT name,duration FROM tracks WHERE duration > 210;

SELECT name FROM compilation WHERE YEAR BETWEEN 2018 AND 2020;

SELECT name FROM singers WHERE name NOT LIKE '% %';

SELECT name FROM tracks WHERE name LIKE '%%мой%%';
SELECT name FROM tracks WHERE name ~'мой|my';
SELECT name FROM tracks WHERE name LIKE any(array['%мой%', '%my%']);