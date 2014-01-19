express           = require('express')
fetchRepositories = require('./lib/fetch_repositories')
redisClient       = require("./config/database")

app         = express()
serverPort  = process.env.PORT || 3000

app.get "/", (req, res) ->
  redisClient.get 'repositories', (err, repositories) ->
    return false if err

    res.setHeader 'Content-Type', 'text/javascript'
    res.send "var customElements = #{repositories};"

app.listen serverPort, ->
  fetchRepositories()
