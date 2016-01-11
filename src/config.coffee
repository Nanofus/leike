configData = {
  "style": "light"
}
packageJson = require('../package.json')

loadCss= (url) ->
  head = document.getElementsByTagName('head')[0]
  link = document.createElement('link')
  link.type = 'text/css'
  link.rel = 'stylesheet'
  link.href = url
  head.appendChild link
  link

loadCss("build/css/" + configData.style + ".css")
