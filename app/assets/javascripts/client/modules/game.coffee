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
  # Pusher.logToConsole = true;

  # pusher = new Pusher('a52ef4ce92582b682a9b', {
  #     cluster: 'ap1',
  #     encrypted: true
  #   });
  # channel = pusher.subscribe($stateParams.channel)

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

  # channel.bind 'move-success',
  #   ()->
  #     audio.footsteps.play()
  # channel.bind 'move-hit',
  #   ()->
  #     audio.wallHit.play()
  # channel.bind 'move-winner',
  #   ()->
  #     audio.winner.play()

  return
Ctrl.$inject = ['$scope', '$state', '$stateParams']
client.controller('GameCtrl', Ctrl)
