// express server

const express = require('express');
const app = express();
const port = 3000;


// routes / pages / endpoints / URIs 
// root route / index route/page

app.get('/', (req, res) => {
    res.send('Hello World');
});