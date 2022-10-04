SELECT  name,YEAR FROM albums WHERE YEAR = 2018;

SELECT name, duration FROM tracks WHERE duration = (SELECT max(duration) FROM tracks);

SELECT name,duration FROM tracks WHERE duration > 210;

SELECT name FROM compilation WHERE YEAR BETWEEN 2018 AND 2020;

SELECT name FROM singers WHERE name NOT LIKE '% %';

SELECT name FROM tracks WHERE name LIKE '%%мой%%';
SELECT name FROM tracks WHERE name ~'мой|my';
SELECT name FROM tracks WHERE name LIKE any(array['%мой%', '%my%']);

/*количество исполнителей в каждом жанре;*/
SELECT mg.id, mg.name, count(s.name)
FROM singers s 
LEFT JOIN singers_musical_genre smg
ON smg.singers_id = s.id
LEFT JOIN musical_genre mg 
ON smg.musical_genre_id = mg.id
GROUP BY mg.id
ORDER BY mg.id;


/*количество треков, вошедших в альбомы 2019-2020 годов; --- сделал на год больше, сути не меняет в общем никакой)*/
SELECT  a.year, count(t.name)
FROM tracks t
LEFT JOIN albums a 
ON t.album_id = a.id
WHERE a.YEAR BETWEEN 2018 AND 2020
GROUP BY a.year;


/*средняя продолжительность треков по каждому альбому;*/
SELECT  a.name, round(avg(t.duration),1)
FROM tracks t
LEFT JOIN albums a 
ON t.album_id = a.id
GROUP BY a.name;


/*все исполнители, которые не выпустили альбомы в 2020 году;*/
SELECT s.name, a.name , a.year
FROM singers s
LEFT JOIN singers_albums sa
ON s.id = sa.singers_id 
LEFT JOIN albums a
ON a.id = sa.albums_id
WHERE a.YEAR != 2020;

SELECT DISTINCT s.name FROM singers s 
WHERE s.name NOT IN (
SELECT DISTINCT s2.name FROM singers s2 
LEFT JOIN singers_albums sa ON s2.id = sa.singers_id
LEFT JOIN albums a ON a.id = sa.albums_id
WHERE a.year = 2020
)
ORDER BY s.name;


/*названия сборников, в которых присутствует конкретный исполнитель (выберите сами - Баста);*/
SELECT DISTINCT c.name
FROM compilation c
LEFT JOIN compilation_tracks ct 
ON c.id = ct.compilation_id 
LEFT JOIN tracks t 
ON t.id = ct.tracks_id
LEFT JOIN albums a 
ON t.album_id = a.id
LEFT JOIN singers_albums sa 
ON a.id = sa.albums_id 
LEFT JOIN singers s 
ON s.id = sa.singers_id
WHERE s.name = 'Баста';


/*название альбомов, в которых присутствуют исполнители более 1 жанра;*/=====================================
SELECT s.name, a.name 
FROM singers s
LEFT JOIN singers_albums sa
ON s.id = sa.singers_id 
LEFT JOIN albums a
ON a.id = sa.albums_id
WHERE s.id = ANY(SELECT s.id FROM singers s  LEFT JOIN singers_musical_genre smg ON smg.singers_id = s.id LEFT JOIN musical_genre mg  ON smg.musical_genre_id = mg.id GROUP BY s.id HAVING count(mg.name) != 1);

SELECT a.name FROM singers_musical_genre smg
JOIN musical_genre mg ON smg.musical_genre_id = mg.id
JOIN singers s ON smg.singers_id = s.id
JOIN singers_albums sa ON sa.singers_id = s.id
JOIN albums a ON sa.albums_id = a.id
GROUP BY a.name
HAVING COUNT(DISTINCT mg.name) > 1;

/*наименование треков, которые не входят в сборники;*/
SELECT name FROM tracks
WHERE id <> ALL(SELECT t.id
FROM compilation c 
JOIN compilation_tracks ct 
ON c.id = ct.compilation_id 
JOIN tracks t 
ON t.id = ct.tracks_id);

SELECT t.name
FROM compilation c 
JOIN compilation_tracks ct 
ON c.id = ct.compilation_id 
RIGHT JOIN tracks t 
ON t.id = ct.tracks_id
WHERE c.id IS NULL;

/*исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);*/
SELECT s.name, t.name, t.duration
FROM singers s
LEFT JOIN singers_albums sa
ON s.id = sa.singers_id 
LEFT JOIN albums a
ON a.id = sa.albums_id
LEFT JOIN tracks t 
ON a.id = t.album_id
WHERE t.duration = (SELECT min(duration) FROM tracks);


/*название альбомов, содержащих наименьшее количество треков.*/
SELECT a.name
FROM albums a
JOIN tracks t 
ON t.album_id = a.id
GROUP BY a.name
HAVING count(t.id) = (SELECT count(id) FROM tracks GROUP BY album_id ORDER BY count LIMIT 1)
ORDER BY a.name;