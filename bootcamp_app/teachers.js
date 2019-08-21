const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

let cohort = process.argv[2];

pool.query(`
SELECT DISTINCT teachers.name AS teacher,
         cohorts.name AS cohort,
         count(assistance_requests.*) AS total_assistances
FROM teachers
JOIN assistance_requests
    ON teachers.id = assistance_requests.teacher_id
JOIN students
    ON students.id = assistance_requests.student_id
JOIN cohorts
    ON cohorts.id = students.cohort_id
WHERE cohorts.name = '${cohort}'
GROUP BY  teachers.name, cohorts.name
ORDER BY teachers.name ASC;
`)
.then(res => {
  res.rows.forEach(instructor => {
    console.log(`${cohort}: ${instructor.teacher}`);
  })
})
.catch(err => {
  console.error('query error', err.stack);
});