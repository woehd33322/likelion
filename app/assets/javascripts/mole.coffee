seconds = 29

startGame = ->
  timer = window.setInterval('updateTime()', 1000)
  document.addEventListener 'click', score, false
  moleTimer = window.setInterval('change()', 700)
  return

updateTime = ->
  document.getElementById('time').innerHTML = seconds
  if seconds > 0
    --seconds
  else
    clearInterval(timer)
    alert '게임이 끝났습니다! 당신의 점수는 ' + score + '점 입니다.'
    endGame()
  return

change = ->
  set = document.getElementById('no' + parseInt(Math.random() * 9))
  set.className = 'focus'
  setTimeout (->
    set.className = 'default'
    if seconds <= 0
      clearInterval(moleTimer)
    return
  ), 700
  return

endGame = ->
  location.href = '/ready'
  return

score = (e) ->
  `var score`
  target = e.target
  score = document.getElementById('score').innerHTML
  if target.className == 'default'
    document.getElementById('score').innerHTML = --score
  else if target.className == 'focus'
    document.getElementById('score').innerHTML = ++score
  return

window.addEventListener 'load', startGame, false