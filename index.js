const socketio = require('socket.io');
const mysql = require('mysql');
const { response, Router } = require('express');
var conn = mysql.createConnection({
  host:"localhost",
  user:"root",
  password:"password",
  database:"guess_who"
});
var express = require('express'),
    app = express(),
    session = require('express-session');
app.use(session({
    cookie: {
      path    : '/',
      httpOnly: false,
      maxAge  : 24*60*60*1000
    },
    secret: '2C44-4D44-WppQ38S',
    resave: true,
    saveUninitialized: true
}));
app.use(express.json());

conn.connect((err)=>{
  if(err){ 
    console.log('Error in DB Connection');
    throw err;
  } else{
    console.log('Connected to the DB!');
  }
})

// Login endpoint
app.post('/login', function (req, res) {
  let usuario = req.body.usuario;
  let pass = req.body.password;
  console.log(req.body);
  conn.query(`SELECT * FROM usuarios WHERE id_usu='${usuario}' and passwd='${pass}'`, function (err, result) {
    console.log(result);
    if (err || result[0] == undefined){
      //throw err;
      res.send('{"mensaje":"login failed"}');
    } else{
      res.send('{"mensaje":"login success!"}');
    }

  });
});


app.post('/registro', (req, res)=>{
  let nombre = req.body.name;
  let nombreUsuario = req.body.username;
  let pais = req.body.country;
  let passwd = req.body.password;
  console.log(req.body);
  conn.query(`SELECT * FROM paises WHERE nombre='${pais}'`, (err, result)=>{
    console.log(result);
    if (err || result[0] == undefined){
      //throw err;
      res.send('{"message":"Pais No encontrado"}');
    } else{
      let idPais = result[0].id_p;
      conn.query(`INSERT INTO usuarios VALUES('${nombreUsuario}','${nombre}','${idPais}',null,'D','${passwd}')`,(err2, result2)=>{
        console.log(result2);
        if (err2){
          console.log(err2);
          res.send('{"message":"sign up failed"}');
        } else{
          res.send('{"message":"success!"}');
        }
      });
      
    }
  })
  
});

app.post('/buscar_puntuacion', (req,res)=>{
  //let id_jugador = req.session.user;
  let id_jugador = req.body.id;
  console.log(req.body);
    conn.query(`SELECT nombre,total_partidas,total_victorias,total_derrotas,total_puntos 
      FROM puntuaciones,usuarios WHERE puntuaciones.id_punt=usuarios.id_puntuacion and usuarios.id_usu='${id_jugador}'`,(err,result)=>{
        console.log(result);
        res.send(`{"total_partidas":"${result[0].total_partidas}","total_derrotas":"${result[0].total_derrotas}","total_victorias":"${result[0].total_victorias}","total_puntos":"${result[0].total_puntos}"}`);
      });

});

app.post('/newGame', (req, res)=>{
  let id_usuario1 = req.body.username;
  console.log('New Game');
  console.log(req.body);
  conn.query(`INSERT INTO partidas (id_usuario1, id_usuario2, id_usuario1_personaje, id_usuario2_personaje, id_usuario_ganador) VALUES ('${id_usuario1}', NULL, NULL, NULL, NULL)`, (err, result)=>{
    if(err) throw err;
    console.log(result);
    res.send(`{"gameId":"${result.insertId}"}`);
  });
});

app.post('/joinGame',(req,res)=>{
  let id_usuario2 = req.body.username;
  let id = req.body.gameId;
  console.log('Join');
  console.log(req.body);
  conn.query(`UPDATE partidas SET id_usuario2 = '${id_usuario2}' WHERE id_game = '${id}'`,(err, result)=>{
    if(err) throw err;
    console.log(result);
    res.send(`{"message":"Unido a la partida"}`);
  });
});

app.post('/getPersonaje', (req,res)=>{
  let username = req.body.usuario;
  let chatId = req.body.chatId;
  console.log(req.body);
  conn.query(`SELECT asignacion_personaje(${chatId},'${username}') as personaje`, (err, result)=>{
    if(err) throw err;
    console.log(result[0]);
    conn.query(`SELECT * FROM personajes WHERE id = '${result[0].personaje}'`, (err2, result2)=>{
      if(err2) throw err2;
      console.log(result2[0]);
      res.send(`{"personaje":"${result2[0].nombre}"}`);
    });
  });
});

app.post('/adivinarPersonaje', (req, res)=>{
  let username = req.body.usuario;
  let chatId = req.body.chatId;
  let personaje = req.body.personaje;
  console.log(req.body);
  conn.query(`SELECT * FROM partidas WHERE id_game = '${chatId}'`, (err, result)=>{
    
  });

})

var server = app.listen(3000);
console.log("app running at http://localhost:3000");

var io = socketio(server);
//socket.io connection for the chat
var users = new Map();
io.on('connection', (socket)=>{
  var user = '';
  console.log("New chat connection: "+ socket.id);
  socket.on('chat', (data)=>{
    console.log(data);
    let username = data.user;
    let chatId = data.chatId;
    socket.join(`${chatId}`);
    console.log(`Username : ${username} joined Chat ID : ${chatId}`);
    user = username;
    users.set(username,chatId);
    console.log(users);
    for (const [key, value] of users) {
      console.log(key + ' = ' + value)
      if(value == chatId)
        io.to(`${chatId}`).emit('newUserToChatRoom',key);
    }
    
  });

  socket.on('leave', (data)=>{
    let chat_data = JSON.parse(data);
    let username = chat_data.user;
    let chatId = chat_data.chatId;

    console.log(`Username : ${username} leaved Room Name : ${chatId}`);
    socket.broadcast.to(`${chatId}`).emit('userLeftChatRoom',user);
    socket.leave(`${chatId}`);
  });

  socket.on('newMessage',(data)=> {
    let messageContent = data.message
    let username = data.username
    let chatId = data.chatId

    console.log(`[Room Number ${chatId}] ${username} : ${messageContent}`)
    
    // Just pass the data that has been passed from the writer socket
    const chatData = {
        user : username,
        messageContent : messageContent,
        chatId : chatId
    }
    socket.broadcast.to(`${chatId}`).emit('updateChat',JSON.stringify(chatData));
  });

}); 
