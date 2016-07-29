Ctrl = ($scope, $state, $stateParams) ->
  $scope._prev = null
  $scope._current= null

  $scope.direction = null
  audio =
    background: document.getElementById('backgroundAudio')
    footsteps: document.getElementById('footsteps')
    wallHit: document.getElementById('wallHit')
    winner: document.getElementById('winner')

  audio.background.onended = ()->
    audio.background.pause()
    audio.background.currentTime = 0
    audio.background.play()
  audio.background.play()

  getDirection = (coords1, coords2) ->
    yDiff = coords1.y - coords2.y
    xDiff = coords1.x - coords2.x

    if (Math.abs(xDiff) > Math.abs(yDiff))
      if (xDiff > 0)
        return 'left'
      else
        return 'right'

    else
      if (yDiff > 0)
        return 'up'
      else
        return 'down'

  $scope.track = ($event) ->
    $scope._prev = {x: $event.pageX, y: $event.pageY}

  $scope.untrack = ($event) ->
    $scope._current = {x: $event.pageX, y: $event.pageY}
    $scope.direction = getDirection($scope._prev, $scope._current)
  $scope.onAudioEnd = (audio) ->
    audioElement = document.getElementById(audio)
    audioElement.pause()
    audioElement.currentTime = 0
  Pusher.logToConsole = true;

  pusher = new Pusher('30187ba71ee217eb669c', {
      encrypted: true
    });
  channel = pusher.subscribe('test_channel')

  channel.bind 'move_success',
    (data)->
      console.log('dfjslsfd')
      # alert(data.message)
      audio.footsteps.play()
  channel.bind 'move_failed',
    ()->
      audio.wallHit.play()
  channel.bind 'game_winner',
    ()->
      audio.winner.play()

  return
Ctrl.$inject = ['$scope', '$state', '$stateParams']
client.controller('GameCtrl', Ctrl)
