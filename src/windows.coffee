# Requirements
packageJson = require('../package.json')

showWindow= (id) ->
  if document.getElementById(id).style.display == "block"
    document.getElementById(id).style.display="none"
  else
    document.getElementById(id).style.display="block"

faq = new Vue(
  el: '#faq'
  data: packageJson: packageJson
)
