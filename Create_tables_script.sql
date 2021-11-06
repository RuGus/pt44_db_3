CREATE TABLE IF NOT EXISTS Genres (
    Id serial PRIMARY KEY,
    Name varchar(50) NOT NULL UNIQUE
    );

CREATE TABLE IF NOT EXISTS Singers (
    Id serial PRIMARY KEY,
    Name varchar(150) NOT NULL UNIQUE
    );

CREATE TABLE IF NOT EXISTS Albums (
    Id serial PRIMARY KEY,
    Name varchar(150) NOT NULL UNIQUE,
    Year integer NOT NULL
    );

CREATE TABLE IF NOT EXISTS Tracks (
    Id serial PRIMARY KEY,
    Name varchar(150) NOT NULL UNIQUE,
    Duration integer NOT NULL,
    Album_id integer NOT NULL REFERENCES Albums(Id)
    );

CREATE TABLE IF NOT EXISTS Collections (
    Id serial PRIMARY KEY,
    Name varchar(150) NOT NULL UNIQUE,
    Year integer NOT NULL
    );

CREATE TABLE IF NOT EXISTS GenreSinger (
    Genre_id integer REFERENCES Genres(id),
    Singer_id integer REFERENCES Singers(id),
    constraint gs primary key (Genre_id, Singer_id)
    );

CREATE TABLE IF NOT EXISTS SingerAlbum (
    Singer_id integer REFERENCES Singers(id),
    Album_id integer REFERENCES Albums(id),
    constraint sa primary key (Singer_id, Album_id)
    );

CREATE TABLE IF NOT EXISTS TrackCollection (
    Track_id integer REFERENCES Tracks(id),
    Collection_id integer REFERENCES Collections(id),
    constraint tc primary key (Track_id, Collection_id)
    );
