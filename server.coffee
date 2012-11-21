express = require 'express'
http = require 'http'
sharejs = require('share').server

class ArtServer
    constructor: () ->
        @app = @setupExpress()
        server = http.createServer @app
        server.listen 80
        options = {'db': {'type': 'none'}}
        sharejs.attach @app, options
        @app.get '*', (req, res) ->
            res.redirect 'editor.html'
    
    setupExpress: () ->
        app = express()
        app.use express.bodyParser()
        dir = __dirname + '/html'
        app.use express.static dir
        return app
            
            
server = new ArtServer()