var express = require('express'),
    app = express(),
    session = require('express-session');
app.use(session({
    secret: '2C44-4D44-WppQ38S',
    resave: true,
    saveUninitialized: true
}));
app.use(express.json());

// Authentication and Authorization Middleware
var auth = function(req, res, next) {
  if (req.session && req.session.user === "daniel")
    return next();
  else
    return res.sendStatus(401);
};

// Login endpoint
app.post('/login', function (req, res) {
  console.log(req.body.usuario);
  if (!req.body.usuario || !req.body.password) {
    res.send('login failed');    
  } else if(req.body.usuario === "daniel" || req.body.password === "123") {
    req.session.user = "daniel";
    res.send("login success!");
  }
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

app.listen(3000);
console.log("app running at http://localhost:3000");