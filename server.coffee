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
        @app.get '/library/test/success.html', (req, res) ->
            res.status 200
            res.send '''
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN"> 
 <HTML> 
 <HEAD> 
      <TITLE>Success</TITLE> 
 </HEAD> 
 <BODY> 
      Success
 </BODY> 
 </HTML>
            '''
        @app.get '*', (req, res) ->
            res.redirect 'editor.html'

    
    setupExpress: () ->
        app = express()
        app.use express.bodyParser()
        dir = __dirname + '/html'
        app.use express.static dir
        app.use express.static dir + '/lib'
        return app
            
            
server = new ArtServer()