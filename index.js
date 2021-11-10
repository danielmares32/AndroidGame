const socket = require('socket.io');
const mysql = require('mysql');
const { response } = require('express');
var conn = mysql.createConnection({
  host:"localhost",
  user:"daniel",
  password:"password",
  database:"guess_who"
});
var express = require('express'),
    app = express(),
    session = require('express-session');
app.use(session({
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

// Authentication and Authorization Middleware
var auth = function(req, res, next) {
  console.log('session: '+req.session.user);
  if (req.session.user != undefined)
    return next();
  else
    return res.sendStatus(401);
};

// Login endpoint
app.post('/login', function (req, res) {
  let usuario = req.body.usuario;
  let pass = req.body.password;
  console.log(req.body);
  conn.query(`SELECT * FROM usuarios WHERE nombre='${usuario}' and passwd='${pass}'`, function (err, result) {
    console.log(result);
    if (err || result[0] == undefined){
      //throw err;
      res.send('login failed');
    } else{
      req.session.user = result[0].nombre;
      res.send('login success!');
    }

  });
});

// Logout endpoint
app.post('/logout', function (req, res) {
  req.session.destroy();
  res.send("logout success!");
});

// Get content endpoint
app.post('/content', auth, function (req, res) {
    res.send("You can only see this after you've logged in.");
});

var server = app.listen(3000);
console.log("app running at http://localhost:3000");

var io = socket(server);
//socket.io connection for the chat
io.on('connection', auth, (socket)=>{
  var user = '';
  console.log("New chat connection: "+ socket.id);
  socket.on('chat', (data)=>{
    let chat_data = JSON.parse(data);
    let user = chat_data.user
    let chatId = chat_data.chatId;
    socket.join(`${chatId}`);
    console.log(`Username : ${user} joined Chat ID : ${chatId}`);

    io.to(`${chatId}`).emit('newUserToChatRoom',user);

  });

  socket.on('leave', (data)=>{
    let chat_data = JSON.parse(data);
    let user = chat_data.user;
    let chatId = chat_data.chatId;

    console.log(`Username : ${user} leaved Room Name : ${chatId}`);
    socket.broadcast.to(`${chatId}`).emit('userLeftChatRoom',user);
    socket.leave(`${chatId}`);
  })

  socket.on('newMessage',(data)=> {
    let messageData = JSON.parse(data)
    let messageContent = messageData.messageContent
    let chatId = messageData.chatId

    console.log(`[Room Number ${chatId}] ${user} : ${messageContent}`)
    
    // Just pass the data that has been passed from the writer socket
    const chatData = {
        user : user,
        messageContent : messageContent,
        chatId : chatId
    }
    socket.broadcast.to(`${chatId}`).emit('updateChat',JSON.stringify(chatData)) // Need to be parsed into Kotlin object in Kotlin
  })

}); 