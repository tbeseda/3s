express = require 'express'
knox = require 'knox'
fs = require 'fs'

app = express()
app.use express.static(__dirname + '/public') # Set static asset source
app.use require('connect-assets')() # Create a compiled asset pipeline
app.set 'view engine', 'jade' # Set the template engine

client = knox.createClient require './settings.json'

# Routes
app.get '/', (req, res) ->
  client.list {}, (err, data) ->
    console.log data[0]
    res.render 'index', {s3_response: data}


app.listen 8000, ->
  console.log 'Express server listening on port 8000.'
