const name = "albert";

const greeting = `Hello, ${name.toUpperCase()}! Welcome to the world of JavaScript.`;

const sqlStatement = `SELECT * FROM users WHERE name = '${name}'`;
const sqlContat = "SELECT * FROM users WHERE name = '" + name + "'";
console.log(greeting);
console.log(sqlStatement);
console.log(sqlContat);
