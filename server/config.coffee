###############################################################################
############## REPLACE CONFIGS IN THIS FILE WITH REAL INFORMATION #############
###############################################################################

module.exports =
  db                 :
    connectionString : 'mongodb://{USERNAME}:{PASSWORD}@{URL}:{PORT}/{DB}'
    credentials      :
      username       : 'DB_USERNAME'
      password       : 'DB_PASSWORD'
      dbName         : 'DB_NAME'
      dbUrl          : 'DB_URL'
      dbPort         : 'DB_PORT'

  mailgun            :
    credentials      :
      apiKey         : 'MAILGUN_API_KEY'
      domain         : 'MAILGUN_DOMAIN'
