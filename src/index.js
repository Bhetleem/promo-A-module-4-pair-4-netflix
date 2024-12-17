const mysql = require('mysql2/promise');
const express = require('express');
const cors = require('cors');

// create and config server
const server = express();
server.use(cors());
server.use(express.json());

server.set('view engine', 'ejs')

// init express aplication
const serverPort = 3000;
server.listen(serverPort, () => {
  console.log(`Server listening at http://localhost:${serverPort}`);
});

//Función para conectarme a la DB
//La comunicación con la base de datos va a ser asincrona

async function getDBConnection() {
  const connection = await mysql.createConnection({
    //config la conexión de mi db
    host: "szzk7.h.filess.io",
    user: "Netflix_waveengine",
    password: "16342dee0fdc2169f9cb5903185c872cc58df8a8",
    database: "Netflix_waveengine",
    port: 3306
  })
  connection.connect();
  return connection;
}

server.get("/movie/:movieId", async (request, response) => {
  const connection = await getDBConnection();
  const sqlQuery = "SELECT * FROM movies WHERE idMovies = ?;";
  const [results] = await connection.query(sqlQuery, [request.params.movieId]);
  connection.end();
  console.log(results);
  response.render('movie')
})


server.get("/movies", async (request, response) => {
  const connection = await getDBConnection();
  const sqlQuery = "SELECT * FROM movies";
  const [results] = await connection.query(sqlQuery);
  console.log(results);
  response.status(200).json({
    success: true,
    movies: results
  })
})
//insertar el nuevo usuario en mi tabla DB
server.post("/sign-up", async (req, res) => {
  const connection = await getDBConnection();
  const query = "INSERT INTO users (email, password) VALUES (?, ?)";
  const [results] = await connection.query(query, [
    email, password
  ])
  console.log(results);

  res.json({});
})
