-- Get the average time of an assistance request.
-- Select just a single row here and name it average_assistance_request_duration
-- In Postgres, we can subtract two timestamps to find the duration between them. (timestamp1 - timestamp2)
SELECT cohorts.name AS name, avg(completed_at - started_at) AS average_assistance_request_duration
FROM assistance_requests
JOIN students
    ON students.id = student_id
JOIN cohorts
    ON students.cohort_id = cohorts.id
GROUP BY  cohorts.name
ORDER BY  average_assistance_request_duration DESC
;


-- Get the cohort with the longest average duration of assistance requests.
SELECT avg(started_at - created_at) AS average_wait_time
FROM assistance_requests
;

-- Get the total duration of all assistance requests for each cohort.
-- Select the cohort's name and the total duration the assistance requests.
-- Order by total_duration.
-- Look at the ERD to see how to join the tables.
SELECT cohorts.name AS cohort, sum(completed_at - started_at) AS total_duration
FROM assistance_requests
JOIN students
    ON students.id = student_id
JOIN cohorts
    ON students.cohort_id = cohorts.id
GROUP BY  cohorts.name
ORDER BY  total_duration ASC;

-- Calculate the average total duration of assistance requests for each cohort.
-- Use the previous query as a sub query to determine the duration per cohort.
-- Return a single row average_total_duration
SELECT avg(total_duration)
FROM 
    (SELECT cohorts.name AS cohort,
         sum(completed_at - started_at) AS total_duration
    FROM assistance_requests
    JOIN students
        ON students.id = student_id
    JOIN cohorts
        ON students.cohort_id = cohorts.id
    GROUP BY  cohorts.name
    ORDER BY  total_duration ASC) AS cohort_durations
;