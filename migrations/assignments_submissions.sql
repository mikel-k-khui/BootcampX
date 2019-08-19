CREATE TABLE assignments (    
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR,
  content TEXT,
  day INTEGER,
  chapter INTEGER,
  duration FLOAT
);

CREATE TABLE assignment_submissions (
  id SERIAL PRIMARY KEY NOT NULL,
  assignment_id INTEGER REFERENCES assignments(id) ON DELETE CASCADE,
  student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
  submission_date DATE,
  duration FLOAT
);