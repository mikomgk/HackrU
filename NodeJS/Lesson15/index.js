const express = require('express')
const bodyParser = require('body-parser')
const app = express()
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
const port = 3000

app.get('/', function (req, res) {
    res.send('Hello World')
})

app.post('/add', function (req, res) {

})

app.listen(port, () => console.log(`app listening on potr ${port}`))




