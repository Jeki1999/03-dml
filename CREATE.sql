CREATE TABLE IF NOT EXISTS musical_genre 
(
	id SERIAL primary key,
	name VARCHAR(20) not null
);

CREATE TABLE IF NOT EXISTS singers
(
	id SERIAL primary key,
	name VARCHAR(20) not NULL,
);

CREATE TABLE IF NOT EXISTS singers_musical_genre
(
	id SERIAL PRIMARY KEY,
	musical_genre_id INT REFERENCES musical_genre(id),
	singers_id INT REFERENCES singers(id)
);

CREATE TABLE IF NOT EXISTS compilation
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	year INT NOT NULL CHECK (YEAR>0)
);

CREATE TABLE IF NOT EXISTS tracks
(
	id SERIAL primary key,
	name VARCHAR(20) NOT NULL,
	duration INT NOT NULL,
	album INT NOT NULL REFERENCES albums(id)
);

CREATE TABLE IF NOT EXISTS compilation_tracks
(
	id SERIAL primary key,
	compilation_id INT REFERENCES compilation(id),
	tracks_id INT REFERENCES tracks(id)
);

CREATE TABLE IF NOT EXISTS albums
(
	id SERIAL primary key,
	name VARCHAR(20) NOT NULL,
	year INT NOT NULL CHECK (YEAR > 0)
);

CREATE TABLE IF NOT EXISTS singers_albums
(
	id SERIAL PRIMARY KEY,
	albums_id INT REFERENCES albums(id),
	singers_id INT REFERENCES singers(id)
);

