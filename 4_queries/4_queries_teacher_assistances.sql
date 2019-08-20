-- Get the total number of assistance_requests for a teacher.
SELECT count(assistance_requests.id) AS total_assistances, teachers.name as name
FROM assistance_requests
JOIN teachers
    ON teachers.id = assistance_requests.teacher_id
GROUP BY teachers.name
ORDER BY count(assistance_requests.id);

-- Get the total number of assistance_requests for a student.
-- Select the student's name and the total assistance requests.
-- Since this query needs to work with any specific student name, use 'Elliot Dickinson' for the student's name here.
SELECT count(assistance_requests.id) AS total_assistances, students.name as name
FROM assistance_requests
JOIN students
    ON students.id = assistance_requests.student_id
GROUP BY students.name
ORDER BY count(assistance_requests.id);


-- Get important data about each assistance request.
-- Select the teacher's name, student's name, assignment's name, and the duration of each assistance request.
-- Subtract completed_at by started_at to find the duration.
-- Order by the duration of the request.
SELECT teachers.name AS teacher,
        students.name AS student,
        assignments.name AS assignment,
        SUM(completed_at - started_at) as duration
FROM assistance_requests
JOIN teachers
    ON teachers.id = teacher_id
JOIN students
    ON students.id = student_id
JOIN assignments
    ON assignments.id = assignment_id
GROUP BY teachers.name, students.name, assignments.name
ORDER BY duration
;

