[source](https://scotch.io/tutorials/creating-a-single-page-todo-app-with-node-and-angular)

#we will be createing:
  Single page application to create and finish todos
  Storing todos in a MongoDB using Mongoose
  Using the Express framework
  Creating a RESTful Node API
  Using Angular for the frontend and to access the API

#Base Setup
1. File Structure
  - public            <!-- holds all our files for our frontend angular application -->
  ----- core.js       <!-- all angular code for our app -->
  ----- index.html    <!-- main view -->
  - package.json      <!-- npm configuration to install dependencies/modules -->
  - server.js         <!-- Node configuration -->

#Installing Modules
package.json
```
{
  "name"         : "node-todo",
  "version"      : "0.0.0",
  "description"  : "Simple todo application.",
  "main"         : "server.js",
  "author"       : "Scotch",
  "dependencies" : {
    "express"    : "~4.7.2",
    "mongoose"   : "~3.6.2",
    "morgan"     : "~1.2.2",
    "body-parser": "~1.5.2",
    "method-override": "~2.1.2"
    }
}
```
#Node Configuration
This is the file where we will:
  Configure our application
  Connect to our database
  Create our Mongoose models
  Define routes for our RESTful API
  Define routes for our frontend Angular application
  Set the app to listen on a port so we can view it in our browser
```
// server.js

// set up ========================
var express  = require('express');
var app      = express();                               // create our app w/ express
var mongoose = require('mongoose');                     // mongoose for mongodb
var morgan = require('morgan');             // log requests to the console (express4)
var bodyParser = require('body-parser');    // pull information from HTML POST (express4)
var methodOverride = require('method-override'); // simulate DELETE and PUT (express4)

// configuration =================

mongoose.connect('mongodb://node:node@mongo.onmodulus.net:27017/uwO3mypu');     // connect to mongoDB database on modulus.io

app.use(express.static(__dirname + '/public'));                 // set the static files location /public/img will be /img for users
app.use(morgan('dev'));                                         // log every request to the console
app.use(bodyParser.urlencoded({'extended':'true'}));            // parse application/x-www-form-urlencoded
app.use(bodyParser.json());                                     // parse application/json
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json
app.use(methodOverride());

// listen (start app with node server.js) ======================================
app.listen(8080);
console.log("App listening on port 8080");

```
#Database Setup
We will be using a remote database hosted on [Modulus.io](https://modulus.io/)
#Start Your App!
node server.js
#Application Flow
#Creating Our Node API
1. Todo Model
```
// define model =================
var Todo = mongoose.model('Todo', {
    text : String
});
```
2. RESTful API Routes
```
// server.js
...

    // routes ======================================================================

    // api ---------------------------------------------------------------------
    // get all todos
    app.get('/api/todos', function(req, res) {

        // use mongoose to get all todos in the database
        Todo.find(function(err, todos) {

            // if there is an error retrieving, send the error. nothing after res.send(err) will execute
            if (err)
                res.send(err)

            res.json(todos); // return all todos in JSON format
        });
    });

    // create todo and send back all todos after creation
    app.post('/api/todos', function(req, res) {

        // create a todo, information comes from AJAX request from Angular
        Todo.create({
            text : req.body.text,
            done : false
        }, function(err, todo) {
            if (err)
                res.send(err);

            // get and return all the todos after you create another
            Todo.find(function(err, todos) {
                if (err)
                    res.send(err)
                res.json(todos);
            });
        });

    });

    // delete a todo
    app.delete('/api/todos/:todo_id', function(req, res) {
        Todo.remove({
            _id : req.params.todo_id
        }, function(err, todo) {
            if (err)
                res.send(err);

            // get and return all the todos after you create another
            Todo.find(function(err, todos) {
                if (err)
                    res.send(err)
                res.json(todos);
            });
        });
    });
```
#Frontend Application with Angular
1. Defining Frontend Route
```
// server.js
...
    // application -------------------------------------------------------------
    app.get('*', function(req, res) {
        res.sendfile('./public/index.html'); // load the single view file (angular will handle the page changes on the front-end)
    });
...
```
2. Setting Up Angular core.js
```
// public/core.js
var scotchTodo = angular.module('scotchTodo', []);

function mainController($scope, $http) {
    $scope.formData = {};

    // when landing on the page, get all todos and show them
    $http.get('/api/todos')
        .success(function(data) {
            $scope.todos = data;
            console.log(data);
        })
        .error(function(data) {
            console.log('Error: ' + data);
        });

    // when submitting the add form, send the text to the node API
    $scope.createTodo = function() {
        $http.post('/api/todos', $scope.formData)
            .success(function(data) {
                $scope.formData = {}; // clear the form so our user is ready to enter another
                $scope.todos = data;
                console.log(data);
            })
            .error(function(data) {
                console.log('Error: ' + data);
            });
    };

    // delete a todo after checking it
    $scope.deleteTodo = function(id) {
        $http.delete('/api/todos/' + id)
            .success(function(data) {
                $scope.todos = data;
                console.log(data);
            })
            .error(function(data) {
                console.log('Error: ' + data);
            });
    };

}
```
3. Frontend View index.html
```
<!-- index.html -->
<!doctype html>

<!-- ASSIGN OUR ANGULAR MODULE -->
<html ng-app="scotchTodo">
<head>
    <!-- META -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"><!-- Optimize mobile viewport -->

    <title>Node/Angular Todo App</title>

    <!-- SCROLLS -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"><!-- load bootstrap -->
    <style>
        html                    { overflow-y:scroll; }
        body                    { padding-top:50px; }
        #todo-list              { margin-bottom:30px; }
    </style>

    <!-- SPELLS -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script><!-- load jquery -->
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.0.8/angular.min.js"></script><!-- load angular -->
    <script src="core.js"></script>

</head>
<!-- SET THE CONTROLLER AND GET ALL TODOS -->
<body ng-controller="mainController">
    <div class="container">

        <!-- HEADER AND TODO COUNT -->
        <div class="jumbotron text-center">
            <h1>I'm a Todo-aholic <span class="label label-info">{{ todos.length }}</span></h1>
        </div>

        <!-- TODO LIST -->
        <div id="todo-list" class="row">
            <div class="col-sm-4 col-sm-offset-4">

                <!-- LOOP OVER THE TODOS IN $scope.todos -->
                <div class="checkbox" ng-repeat="todo in todos">
                    <label>
                        <input type="checkbox" ng-click="deleteTodo(todo._id)"> {{ todo.text }}
                    </label>
                </div>

            </div>
        </div>

        <!-- FORM TO CREATE TODOS -->
        <div id="todo-form" class="row">
            <div class="col-sm-8 col-sm-offset-2 text-center">
                <form>
                    <div class="form-group">

                        <!-- BIND THIS VALUE TO formData.text IN ANGULAR -->
                        <input type="text" class="form-control input-lg text-center" placeholder="I want to buy a puppy that will love me forever" ng-model="formData.text">
                    </div>

                    <!-- createToDo() WILL CREATE NEW TODOS -->
                    <button type="submit" class="btn btn-primary btn-lg" ng-click="createTodo()">Add</button>
                </form>
            </div>
        </div>

    </div>

</body>
</html>
```
#Conclusion
  RESTful Node API using Express
  MongoDB interaction using mongoose
  Angular AJAX $http calls
  Single page application w/ no refreshes
  Dogfooding (sorry, I really like that word)
#Test the Application
  Make sure you have Node and npm installed
  Clone the repo: git clone git@github.com:scotch-io/node-todo
  Install the application: npm install
  Start the server: node server.js
  View in your browser at http://localhost:8080