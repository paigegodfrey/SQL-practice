-- https://github.com/WebDevSimplified/Learn-SQL

CREATE TABLE bands (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
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

-- 3. Select the oldest album

-- 4. Get all bands that have albums

-- 5. Get all bands that have no albums

-- 6. Get the longest album

-- 7. Update the release year of the album with no release year

-- 8. Insert a record for your favorite band and one of their albums
 
-- 9. Delete the and and album you added in #8

-- on delete cascade handles album table

-- 10. Get the average length of all songs

-- 11. Select the longest song off each album

-- 12. Get the number of songs for each band
