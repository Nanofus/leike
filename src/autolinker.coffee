Autolinker = require( 'autolinker' )
autolinker = new Autolinker({newWindow: false, stripPrefix: false})

observer = new MutationObserver (mutations) ->
  for i in [0...mutations.length]
    for j in [0...mutations[i].addedNodes.length]
      if mutations[i].addedNodes[j].className == "entry"
        autolink()

observer.observe(document.getElementById('entry-list'), {childList: true, subtree: true})

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
