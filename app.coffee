express = require 'express'
knox    = require 'knox'
config  = require './settings.json'

app = express()
app.use express.static(__dirname + '/public')
app.use(express.basicAuth('admin', config.password))
app.use require('connect-assets')()
app.set('view engine', 'jade')

client = knox.createClient(config.S3)

app.get '/', (req, res) ->
  client.list {}, (err, data) ->
    res.render 'index', {s3_response: data}

app.get '/url', (req, res) ->
  filename = req.query.filename
  expiration = new Date()
  expiration.setMonth(expiration.getMonth() + 1)
  url = client.signedUrl(filename, expiration)
  res.json url: url

app.listen 8080, ->
  console.log 'Express server listening on port 8080.'
