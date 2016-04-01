config = require './config'

module.exports =

  ###*
    Build MongoDB connection string.
  ###
  getMongoUrl: ->

    { username, password, dbName, dbUrl, dbPort } = config.db.credentials
    cs = config.db.connectionString

    cs = cs.replace '{USERNAME}', username
           .replace '{PASSWORD}', password
           .replace '{URL}',      dbUrl
           .replace '{PORT}',     dbPort
           .replace '{DB}',       dbName

    return cs
