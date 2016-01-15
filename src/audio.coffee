copyTo = new Audio('sounds/copyTo.wav')
copyFrom = new Audio('sounds/copyFrom.wav')

playSound= (sound) ->
  if configJson.audioEnabled
    if sound == 'copyTo'
      copyTo.volume = (configJson.audioVolume / 100)
      copyTo.play()
    if sound == 'copyFrom'
      copyFrom.volume = (configJson.audioVolume / 100)
      copyFrom.play()

playCopyTo= ->
  playSound('copyTo')

playCopyFrom= ->
  playSound('copyFrom')
