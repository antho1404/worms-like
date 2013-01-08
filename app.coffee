express = require 'express'
http    = require 'http'
fs      = require 'fs'
expresscoffee = require 'express-coffee'
routes  = require './routes'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use expresscoffee { path: __dirname + '/public' }
  app.use express.static __dirname + '/public'

app.configure 'development', ->
  app.use express.logger('dev')
  app.use express.errorHandler { dumpExceptions: true, showStack: true }


app.configure 'production', ->
  app.use express.errorHandler

app.get '/', routes.index

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port #{app.get 'port'}"
