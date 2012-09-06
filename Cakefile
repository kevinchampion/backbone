{exec} = require 'child_process'
task 'compile', 'Compiles and watches all coffee files in the javascript folder', ->
  exec 'coffee --compile --watch javascript/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
