const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

//inputs code from devloper
const queryStr = `
SELECT students.id as id, students.name as student_name, cohorts.name as cohort
FROM students
JOIN cohorts ON cohort_id=cohorts.id
WHERE cohorts.name LIKE $1
LIMIT $2;
`;

//inputs from command line
const cohort = process.argv[2];
const resultLimit = process.argv[3];
const values = [`%${cohort}%`, resultLimit];

pool.query(queryStr, values)
  .then(res => {
    res.rows.forEach(user => {
      console.log(`${user.student_name} has an id of ${user.id} and was in the ${user.cohort} cohort`);
    });
  })
  .catch(err => {
    console.log("In pool.query catch:", values);
    console.error('query error', err.stack);
  });