-- -- List each assignment with the total number of assistance requests with it.
-- -- Select the assignment's id, day, chapter, name and the total assistances.
-- -- Order by total assistances in order of most to least.
SELECT assignments.id AS id,
         name,
         day,
         chapter,
         count(assistance_requests.*) AS total_requests
FROM assignments
JOIN assistance_requests
    ON assignments.id = assistance_requests.assignment_id
GROUP BY  assignments.id, name, day, chapter
ORDER BY  total_requests DESC;

-- Get each day with the total number of assignments and the total duration of the assignments.
-- Select the day, number of assignments, and the total duration of assignments.
-- Order the results by the day.
SELECT day, count(id) AS number_of_assignments, sum(duration) as duration
FROM assignments
GROUP BY day
ORDER BY day ASC;