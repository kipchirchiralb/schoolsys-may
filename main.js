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
      // query and get classrooms 
      dbConnection.query("SELECT * FROM classroom",(qErr, classroomData)=>{
        if(qErr){
          res.status(500).send("Could not get classroom data")
        }else{
          res.render("students.ejs", { students: results, classrooms: classroomData });
        }
      })
    }
  });
});

app.get("/subjects", (req, res) => {
  dbConnection.query("SELECT * FROM subject", (err, results) => {
    if (err) {
      res.status(500).send("Error fetching subjects data");
    } else {
      res.render("subjects.ejs", { subjects: results });
    }
  });
});

app.post("/add-subject", express.urlencoded({ extended: true }), (req, res) => {
  const sqlQuery = `INSERT INTO subject (subject_name, subject_code, category) VALUES ('${req.body.subject_name}', '${req.body.subject_code}', '${req.body.category}')`;
  // template literals
  console.log(sqlQuery);
  dbConnection.query(sqlQuery, (err) => {
    if (err) {
      res.status(500).send("Error adding subject");
    } else {
      res.redirect("/subjects");
    }
  });
});
// TASK - ADD A STUDENT TO THE STUDENTS TABLE USING A POST REQUEST AND REDIRECT TO /STUDENTS AFTER ADDING THE STUDENT
// start the server - must be at the bottom of the file/code
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
// before running install express and ejs using "npm install express ejs mysql"
