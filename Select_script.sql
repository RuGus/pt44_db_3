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

-- количество исполнителей в каждом жанре;
SELECT g.name, count(s.name) from genres g
JOIN genresinger gs ON gs.genre_id = g.id
JOIN singers s ON s.id = gs.singer_id
GROUP BY g.name;

-- количество треков, вошедших в альбомы 2019-2020 годов;
SELECT count(t.name) from albums a
JOIN tracks t ON t.album_id = a.id
WHERE a.year in (2019, 2020);

-- средняя продолжительность треков по каждому альбому;
SELECT a.name, AVG(t.duration) from albums a
JOIN tracks t ON t.album_id = a.id
GROUP BY a.name;

-- все исполнители, которые не выпустили альбомы в 2020 году;
SELECT s.name FROM singers s
WHERE s.id NOT IN
    (SELECT s.id from singers s
    JOIN singeralbum sa ON sa.singer_id = s.id
    JOIN albums a ON a.id = sa.album_id
    WHERE a.year = 2020);

-- названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT c.name from collections c
JOIN trackcollection tc ON tc.collection_id = c.id
JOIN tracks t ON t.id = tc.track_id
JOIN albums a ON a.id = t.album_id
JOIN singeralbum sa ON sa.album_id = a.id
JOIN singers s ON s.id = sa.singer_id
WHERE s.name = 'ABBA'
GROUP BY c.name;

-- название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT agc.album_name FROM
    (SELECT a.name album_name, count(g.name) FROM albums a
    JOIN singeralbum sa ON sa.album_id = a.id
    JOIN singers s ON s.id = sa.singer_id
    JOIN genresinger gs ON gs.singer_id = s.id
    JOIN genres g ON g.id = gs.genre_id
    GROUP BY a.name
    HAVING count(g.name) > 1) agc;

-- наименование треков, которые не входят в сборники;
SELECT t.name FROM tracks t
WHERE t.id NOT IN
    (SELECT track_id FROM trackcollection);

-- исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT s.name FROM singers s
JOIN singeralbum sa ON sa.singer_id = s.id
JOIN tracks t ON t.album_id = sa.album_id
WHERE t.duration = 
    (SELECT MIN(duration) FROM tracks);


-- название альбомов, содержащих наименьшее количество треков.
SELECT album_name FROM 
    (SELECT a.name album_name, count(t.name) count_tracks FROM albums a
    JOIN tracks t ON t.album_id = a.id
    GROUP BY a.name) atc
    WHERE atc.count_tracks = 
        (SELECT MIN(count_tracks) FROM 
            (SELECT a.name album_name, count(t.name) count_tracks FROM albums a
            JOIN tracks t ON t.album_id = a.id
            GROUP BY a.name) atc);
