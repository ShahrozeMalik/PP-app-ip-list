require('dotenv').config();
const express = require('express');
const mysql = require('mysql');

const app = express();

const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

connection.connect();
const router = express.Router();

router.get('/list', (req, res) => {
    connection.query(`SELECT ip FROM requestip`, (err, result)=>{
        if (err) {
            console.log("Error", err);
            res.status(500).json({
                message: "Internal server error"
            })
        }
        else {
            console.log("result--", result);
            res.status(200).json({
                ips : result.map(rowData => (rowData.ip))
            })
        }
    })
})
router.use('/', (req, res) => {
    const ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
    console.log("Ip", ip)
    connection.query(`INSERT INTO requestip (ip) VALUES ('${ip}')`, (err, result) => {
        if (err) {
            console.log("Error", err);
            res.status(500).json({
                message: "Internal server error"
            })
        }
        else {
            console.log("result--", result);
            res.status(200).json({
                message: "Ip saved"
            })
        }
    })
})

app.use('/client-ip', router)

app.listen(3000, () => {
    console.log("Server started on port 3000")
})