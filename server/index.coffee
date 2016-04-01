express    = require 'express'
path       = require 'path'
bodyParser = require 'body-parser'
boom       = require 'express-boom'
routes     = require './routes'
compose    = require './compose'
config     = require './config'
app        = express()
router     = express.Router()
port       = process.env.PORT or 8888

app.use bodyParser.urlencoded extended: yes
app.use bodyParser.json()
app.use boom()
app.use express.static path.resolve "#{__dirname}/../client"

routes.init app, router
compose.init app, router
app.listen port

console.log "\nServer started on http://localhost:#{port}\n"
