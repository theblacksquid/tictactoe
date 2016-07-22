
{exec} = require 'child_process'

task 'bake-dev', 'Build project from src/*.coffee to lib/*.js', ->
  exec 'cat src/* | coffee --compile --stdio > lib/bundle.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
    console.log 'baking done.'

task 'bake-prod', 'Build project for production use. Compresses lib/bundle.js', ->
  exec 'cat src/* | coffee --compile --stdio | uglifyjs - -c -m> lib/app.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
    console.log 'baking done.'