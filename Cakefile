
{exec} = require 'child_process'

task 'build', 'Build project from src/*.coffee to lib/*.js', ->
  exec 'cat src/* | coffee --compile --stdio > lib/bundle.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

