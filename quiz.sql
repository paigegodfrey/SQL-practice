-- https://github.com/WebDevSimplified/Learn-SQL

CREATE TABLE bands (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  release_year INTEGER,
  band_id INTEGER NOT NULL REFERENCES bands(id) ON DELETE CASCADE
);

-- 1. Create a songs table
CREATE TABLE song
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  length FLOAT NOT NULL,
  album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE
);

-- 2. Select only the names of all the bands
SELECT name AS 'Band Name' FROM bands;

-- 3. Select the oldest album
SELECT * FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;

-- 4. Get all bands that have albums
/* This assummes all bands have a unique name */
SELECT DISTINCT name AS 'Band Name' FROM b AS bands
JOIN albums AS a ON b.id = a.band_id;

/* If bands do not have a unique name */
SELECT name AS 'Band Name' FROM bands AS b
JOIN albums AS a ON b.id = a.band_id
GROUP BY a.band_id;
-- HAVING COUNT(a.id) > 0; // inner join already handles this

-- 5. Get all bands that have no albums
SELECT name AS 'Band Name' FROM bands AS b
LEFT JOIN albums AS a ON b.id = a.band_id
GROUP BY a.band_id
HAVING COUNT(a.id) = 0;

-- 6. Get the longest album
SELECT 
  name AS 'Name', 
  release_year AS 'Release Year', 
  SUM(s.length) AS 'Duration' 
FROM albums AS a
JOIN songs AS s on a.id = s.album_id
GROUP BY s.album_id
ORDER BY Duration DESC
LIMIT 1;

-- 7. Update the release year of the album with no release year
/* This is the query used to get the id */
SELECT id FROM albums 
WHERE release_year IS NULL;

UPDATE albums
SET release_year = 1986
WHERE id = 4;

-- 8. Insert a record for your favorite band and one of their albums
INSERT INTO bands (name)
VALUES 'The Used'; 

/* This is the query used to get the id of the band just added */
SELECT id FROM bands
ORDER BY id DESC 
LIMIT 1;

INSERT INTO albums (name, release_year, band_id)
VALUES ('In Love and Death', 2004, 8);

-- 9. Delete the and and album you added in #8
DELETE FROM bands
WHERE id = 8;
-- on delete cascade handles album table

-- 10. Get the average length of all songs
SELECT AVG(length) AS 'Average Song Duration' from songs;

-- 11. Select the longest song off each album
SELECT 
  name AS 'Album', 
  release_year AS 'Release Year', 
  MAX(s.length) AS 'Duration'
FROM albums
JOIN songs AS s ON a.id = s.album_id
GROUP BY s.album_id;

-- 12. Get the number of songs for each band
SELECT 
  b.name AS 'Band', 
  COUNT(s.id) AS 'Number of Songs'
FROM bands AS b
JOIN albums AS a ON b.id = a.band_id
JOIN songs AS s ON a.id = s.album_id
GROUP BY a.band_id;
