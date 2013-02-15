express = require 'express'
knox    = require 'knox'
fs      = require 'fs'
config  = require './settings.json'

app = express()
app.use express.static(__dirname + '/public')
app.use require('connect-assets')()
app.set('view engine', 'jade')

client = knox.createClient(config)

app.get '/', (req, res) ->
  client.list {}, (err, data) ->
    res.render 'index', {s3_response: data}

app.get '/url', (req, res) ->
  filename = req.query.filename
  expiration = new Date()
  expiration.setMonth(expiration.getMonth() + 1)
  url = client.signedUrl(filename, expiration)
  res.json url: url

app.listen 8000, ->
  console.log 'Express server listening on port 8000.'
