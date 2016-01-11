Autolinker = require( 'autolinker' )
autolinker = new Autolinker({newWindow: false})

domChanged= ->
  autolink()

autolink= ->
  entries = document.getElementsByClassName( 'entry-content' )
  for el in entries
    el.innerHTML = autolinker.link el.innerHTML
  links = document.getElementsByTagName( 'a' )
  for link in links
    url = link.getAttribute('href')
    if url != "#"
      link.setAttribute "onclick","openLinkExternally(\""+url+"\")"
      link.setAttribute "href","#"

setInterval (->
  autolink()
), 1000
