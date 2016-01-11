# Requirements
packageJson = require('../package.json')

showFaq= () ->
  if document.getElementById("faq").style.display == "block"
    document.getElementById("faq").style.display="none"
  else
    document.getElementById("faq").style.display="block"

faq = new Vue(
  el: '#faq'
  data: packageJson: packageJson
)
