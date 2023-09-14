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
