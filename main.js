// express server
const express = require("express");
const app = express();
const port = 3000;
// using mysql2 package/module to connect to mysql database
const mysql = require("mysql2");
const dbConnection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "tendamema",
  database: "school_ms",
});

// routes / pages / endpoints / URIs
// root route / index route/page
app.get("/", (req, res) => {
  res.render("index.ejs");
});
app.get("/students", (req, res) => {
  // connect to db and get data from students table
  dbConnection.query("SELECT * FROM student", (err, results) => {
    if (err) {
    //   console.error("Error fetching students data:", err);
      res.status(500).send("Error fetching students data");
    } else {
    //   console.log("Students data fetched successfully:", results);
      res.render("students.ejs", { students: results });
    }
  });
});
app.get("/subjects", (req, res) => {
  res.render("subjects.ejs");
});

// start the server - must be at the bottom of the file/code
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
// before running install express and ejs using "npm install express ejs mysql"
