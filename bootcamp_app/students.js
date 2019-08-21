const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

let cohort = process.argv[2];
let result_limit = process.argv[3]

pool.query(`
SELECT students.id as id, students.name as student_name, cohorts.name as cohort
FROM students
JOIN cohorts ON cohort_id=cohorts.id
WHERE cohorts.name LIKE '${cohort}%'
LIMIT ${result_limit || 5};
`)
.then(res => {
  res.rows.forEach(user => {
    console.log(`${user.name} has an id of ${user.id} and was in the ${user.cohort} cohort`);
  })
})
.catch(err => {
  console.error('query error', err.stack);
});