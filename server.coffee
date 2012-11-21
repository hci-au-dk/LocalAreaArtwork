express = require 'express'
http = require 'http'
sharejs = require('share').server

class ArtServer
    constructor: () ->
        @app = @setupExpress()
        server = http.createServer @app
        server.listen 8000
        options = {'db': {'type': 'none'}}
        sharejs.attach @app, options
    
    setupExpress: () ->
        app = express()
        app.use express.bodyParser()
        dir = __dirname + '/html'
        app.use express.static dir
        return app
            
            
server = new ArtServer()