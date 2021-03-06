-- -- Get the total amount of time that a student has spent on all assignments.

-- SELECT SUM(assignment_submissions.duration) as total_duration
-- FROM students
-- JOIN assignment_submissions ON assignment_submissions.student_id = students.id
-- WHERE students.name IN ('Ibrahim Schimmel');

-- -- Get the total amount of time that all students from a specific cohort have spent on all assignments.
-- SELECT SUM(assignment_submissions.duration) as total_duration
-- FROM assignment_submissions
-- JOIN students ON assignment_submissions.student_id = students.id
-- JOIN cohorts ON students.cohort_id = cohorts.id
-- WHERE cohorts.name IN ('FEB12');

-- -- Get the total amount of time that all students from current cohort have spent on all assignments.
-- SELECT students.name as student, sum(assignment_submissions.duration) as total_durations
-- FROM assignment_submissions
-- JOIN students ON students.id = student_id WHERE students.end_date IS NULL
-- GROUP BY students.name;

-- Get the total amount of time that all students from current cohort have spent on all assignments but less than 100 submissions.
SELECT students.name as student, sum(assignment_submissions.duration) as total_durations
FROM assignment_submissions
JOIN students ON students.id = student_id WHERE students.end_date IS NULL
GROUP BY students.name
HAVING count(assignment_submissions.*) < 100;