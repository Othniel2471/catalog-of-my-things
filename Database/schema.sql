-- Create the items table (common properties for Game, Book and MusicAlbum)
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  genre VARCHAR(255),
  author VARCHAR(255),
  source VARCHAR(255),
  label VARCHAR(255),
  publish_date DATE,
  archived BOOLEAN  
);

-- Create the authors table (Author-specific properties)
CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  item_id INTEGER REFERENCES items(id)
);

-- Create the games table (Game-specific properties)
CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  multiplayer BOOLEAN,
  last_played_at DATE,
  item_id INTEGER REFERENCES items(id)
);

CREATE TABLE Book (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  item_id INTEGER NOT NULL,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  publisher VARCHAR(255) NOT NULL,
  cover_state VARCHAR(255) NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
)

CREATE TABLE  Label (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  item_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  color VARCHAR(255) NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
)

CREATE TABLE  MusicAlbum (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  item_id INTEGER NOT NULL,
  on_spotify BOOLEAN NOT NULL,
  publish_date DATE NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
)

CREATE TABLE Genre (
  id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  item_id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  FOREIGN KEY (item_id) REFERENCES items(id)
)

CREATE INDEX idx_music_albums_on_spotify ON MusicAlbum (on_spotify);
CREATE INDEX idx_books_publisher ON Book (publisher);
CREATE INDEX idx_labels_color ON Label (color);
CREATE INDEX idx_genres_name ON Genre (name);
CREATE INDEX idx_items_genre ON items (genre);
CREATE INDEX idx_items_author ON items (author);


