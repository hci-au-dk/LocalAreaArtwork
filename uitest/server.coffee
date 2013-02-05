express = require('express')
app = express()
server = require('http').createServer app
io = require('socket.io').listen server

app.use express.bodyParser()
dir = __dirname + '/html'
app.use express.static dir
server.listen 80

io.sockets.on 'connection', (socket) ->
  socket.on 'inProximity', (data) ->
    io.sockets.emit 'inProximity', (data)
    #socket.emit 'news', { hello: 'world' }
    