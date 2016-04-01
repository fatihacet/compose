###*
  >>> `src/templates/foo/bar.hbs`
  <<< `[ 'foo', 'bar' ]`

  @param {string} path Handlebars template path
  @return {Array<string>} sanitized path.
###
sanitizePath = (path) ->

  return path.replace('.hbs', '')
             .replace('client/templates/', '')
             .split('/')


module.exports = (grunt) ->

  options     =
    compile   :
      files   : 'dist/client/js/templates.js': 'client/templates/**/*.hbs'
      options :
        namespace: (path) ->
          parts = sanitizePath path
          parts.pop()
          parts.unshift 'compose.templates'
          return parts.join '.'

        processName: (path) ->
          parts = sanitizePath path
          return parts[parts.length - 1]


  grunt.config 'handlebars', options
