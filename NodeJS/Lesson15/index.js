const express = require('express')
const bodyParser = require('body-parser')
const { Pool } = require('pg')
const pool = Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: true
})

const app = express()
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
const port = process.env.PORT || 3000

function execQuery(query, args) {
    pool.query(query, args, (err, res) => {
        if (res) {
            return res
        } else if (err) {
            return err
        }
    })
}

app.get('/', function (req, res) {
    res.send('Hello World')
})

app.post('/add', function (req, res) {

})

app.get("/init", function (req, res) {
    const sql = `
        CREATE TABLE student(
            id SERIAL,
            firstname TEXT,
            lastname TEXT
        )`
    res.json(execQuery(sql, []))
})

app.get('/add', (req, res) => {
    let student = req.body
    const sql = `INSERT INTO students (firstname, lastname)
                VALUES($1, $2)`
    const args = [student.firstname, student.lastname]
    res.json(execQuery(sql, args))
})

app.get('/students', (req, res) => {
    const sql = `SELECT * FROM students`
    res.json(execQuery(sql, []))
})

app.listen(port, () => console.log(`app listening on port ${port}`))
