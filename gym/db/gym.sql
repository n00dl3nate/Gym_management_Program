DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS timetables;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;

CREATE TABLE  members
(
  id SERIAL8 PRIMARY KEY,
  f_name VARCHAR(255),
  l_name VARCHAR(255),
  premium BOOLEAN,
  fitness_level INT2
);

CREATE TABLE  sessions
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  fitness_level INT2
);

CREATE TABLE timetables
(
  id SERIAL8 PRIMARY KEY,
  session_id INT8 REFERENCES sessions(id) ON DELETE CASCADE,
  class_time TIME,
  capacity INT2
);

CREATE TABLE  bookings
(
  id SERIAL8 PRIMARY KEY,
  member_id INT8 REFERENCES members(id) ON DELETE CASCADE,
  timetable_id INT8 REFERENCES timetables(id) ON DELETE CASCADE
);
