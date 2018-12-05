let express = require('express')
let app = express()
const unchecked = "unchecked"
const checked = "checked"
let id = 1
let tasks = new Todos()

function Todo(description, status, orderLocation) {
    this.description = description
    this.status = status
    this.orderLocation = orderLocation
    this.toogle = function () {
        this.status = status == checked ? unchecked : checked
    }
    this.edit = function (newDesc) {
        this.description = newDesc
    }
}

function Todos() {
    this.list = {}
    this.add = function (task) {
        if (typeof task === "Todo") {
            let index = id.toString()
            list[index] = task
            return id++
        }
    }
    this.delete = function (id) {
        delete list.id
    }
    this.getList = function () {
        return this.list
    }
    this.deleteList = function () {
        this.list = {}
    }
}

app.get()

app.get('/toggle', function (req, res) {
    let id =req.query
    tasks[id].toogle
    res.end('toggled')
})

app.post('/add', function (req, res) {
    let body = req.body
    let task = JSON.parse(body)
    let t = new Todo(task.description, task.status, parseInt(task.orderLocation))
    let id = tasks.add(t)
    res.end(id)
})

app.get('/delete', function (req, res) {
    let id = req.query
    tasks.delete(id)
    res.end('deleted')
})

app.get('/getAllTasks', function (req, res) {
    res.json(tasks)
})

app.get('deleteAllTasks', function (req, rea) {
    tasks.deleteList()
    res.end('deleted')
})

app.get('/hello', function (req, res) {
    res.end('<h1>Hello World\n</h1>')
})

app.get('/todo', function (req, res) {
    res.json(todo)
})

app.listen(3000)