const mysql = require('mysql');
var connection = mysql.createConnection({multipleStatements: true});
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'raktar',
    multipleStatements: true,
});

db.connect(err => {
    if(err){
        throw err;
    } else{
        console.log("MySQL Csatlakoztatva");
    }
});


module.exports = db;