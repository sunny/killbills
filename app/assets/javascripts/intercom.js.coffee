i.q = []
i.c = (args) -> i.q.push(args)
window.Intercom = i
async_load = ->
  s = document.createElement('script')
  s.src = 'https://api.intercom.io/api/js/library.js'
  x = document.getElementsByTagName('script')[0]
  x.parentNode.insertBefore(s, x)
if window.attachEvent
  window.attachEvent 'onload', async_load
else
  window.addEventListener 'load', async_load, false
