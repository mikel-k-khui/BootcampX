-- Get all cohorts with 18 or more students.
-- Select the cohort name and the total students.
-- Order by total students from smallest to greatest.
SELECT cohorts.name AS cphort_name,
         count(students.*) AS student_count
FROM students
JOIN cohorts
    ON cohorts.id = students.cohort_id
GROUP BY  cohorts.name
HAVING count(students.*) >= 18
ORDER BY  count(students.*) ASC;
-- 
-- Get the total number of assignment submissions for each cohort.
-- Select the cohort name and total submissions.
-- Order the results from greatest to least submissions.
SELECT cohorts.name AS cohort,
         count(assignment_submissions.*) AS total_submissions
FROM students
JOIN cohorts
    ON cohorts.id = students.cohort_id
JOIN assignment_submissions
    ON students.id = assignment_submissions.student_id
GROUP BY  cohorts.name
ORDER BY  count(assignment_submissions.*) DESC;
-- 
-- Get currently enrolled students' average assignment completion time.
-- Select the students name and average time from assignment submissions.
-- Order the results from greatest duration to least greatest duration.
-- A student will have a null end_date if they are currently enrolled
SELECT students.name AS student,
         avg(assignment_submissions.duration) AS average_assignment_duration
FROM students
JOIN assignment_submissions
    ON students.id = assignment_submissions.student_id
WHERE students.end_date IS NULL
GROUP BY  students.name
ORDER BY  avg(assignment_submissions.duration) DESC;

-- Get the students who's average time it takes to complete an assignment is less than the average estimated time it takes to complete an assignment.
-- Select the name of the student, their average completion time, and the average suggested completion time.
-- Order by average completion time from smallest to largest.
-- Only get currently enrolled students.
-- This will require data from students, assignment_submissions, and assignments.
SELECT students.name AS student,
         avg(assignment_submissions.duration) AS average_assignment_duration,
         avg(assignments.duration) AS average_estimated_duration
FROM students
JOIN assignment_submissions
    ON students.id = assignment_submissions.student_id
JOIN assignments
    ON assignment_submissions.assignment_id = assignments.id
WHERE students.end_date IS NULL
GROUP BY  students.name
HAVING avg(assignment_submissions.duration) < avg(assignments.duration)
ORDER BY  avg(assignment_submissions.duration) ASC;