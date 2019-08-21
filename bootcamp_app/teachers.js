const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

let cohort = process.argv[2];
const values = [`${cohort}` || 'JUL02'];
const queryStr = `
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
WHERE cohorts.name = $1
GROUP BY  teachers.name, cohorts.name
ORDER BY teachers.name ASC;
`;

pool.query(queryStr, values)
  .then(res => {
    console.log("In pool.query then:", values);
    res.rows.forEach(instructor => {
      console.log(`${instructor.cohort}: ${instructor.teacher}`);
    });
  })
  .catch(err => {
    console.log("In pool.query catch:", values);
    console.error('query error', err.stack);
  });