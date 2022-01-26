const express = require('express');
const mysql = require('mysql');
const route = require('./routes/route');



const app = express();
const bodyParser = require('body-parser');
app.use(bodyParser.json());
const  { db }  = require("./config/dbConfig");
app.use(express.static( "public" ) );
app.set("view engine", "ejs");
app.use(express.urlencoded({extended: false}));
app.use(route);

const PORT = process.env.PORT || 8080;


app.listen(PORT, () =>{
    console.log("App listening at: http://localhost:8080/");
});
