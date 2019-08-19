-- Get the names of all of the students from a single cohort.
SELECT id, name
FROM students
WHERE cohort_id = '1'
ORDER BY name ASC;
-- 
-- Select the total number of students who were in the first 3 cohorts.
-- 
SELECT cohort_id, count(id) AS student_count
FROM students
WHERE cohort_id < 4
GROUP BY cohort_id;
-- 
-- Get all of the students that don't have an email or phone number.
SELECT name, id, cohort_id
FROM students
WHERE email IS NULL OR phone IS NULL;
-- 
-- Get all of the students without a gmail.com or phone number.
SELECT name, email, phone, id, cohort_id
FROM students
WHERE email NOT LIKE '%@gmail.%' AND phone IS NULL;
-- 
-- Get all of the students currently enrolled.
-- A student's end date will be NULL when they are currently enrolled in Bootcamp.
SELECT name, id, cohort_id
FROM students
WHERE end_date IS NULL AND cohort_id IS NOT NULL
ORDER BY cohort_id;
-- 
-- Get all graduates without a linked Github account.
SELECT name, email, phone
FROM students
WHERE github IS NULL AND end_date < NOW();