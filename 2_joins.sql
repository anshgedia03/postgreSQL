CREATE TABLE team (
  id SERIAL PRIMARY KEY,
  team_name VARCHAR(50)
);

CREATE TABLE players (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  team_id INT REFERENCES team(id)
);


INSERT INTO team (team_name) VALUES
('India'),
('Australia'),
('England'),
('Pakistan');

INSERT INTO players (name, team_id) VALUES
('Virat Kohli', 1),
('Rohit Sharma', 1),
('Steve Smith', 2),
('Joe Root', 3),
('Babar Azam', 4),
('john doe', NULL); 



SELECT * FROM players;
SELECT * FROM team;

SELECT p.name, t.team_name
FROM players p
INNER JOIN team t
ON p.team_id = t.id;

SELECT p.name, t.team_name
FROM players p
LEFT JOIN team t
ON p.team_id = t.id;

SELECT p.name, t.team_name
FROM players p
RIGHT JOIN team t
ON p.team_id = t.id;

