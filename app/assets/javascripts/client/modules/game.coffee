Ctrl = ($scope, $state, $stateParams, Game) ->
  $scope._prev = null
  $scope._current= null

  $scope.direction = null
  audio =
    background: document.getElementById('backgroundAudio')
    footsteps: document.getElementById('footsteps')
    wallHit: document.getElementById('wallHit')
    winner: document.getElementById('winner')
  $scope.playerId = $stateParams.id
  $scope.channel = $stateParams.channel

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
    $scope.move({player_id: $scope.playerId, direction: $scope.direction})

  # $scope.move = ->
  #   Game.move({move: {player_id: $scope.playerId, direction: $scope.direction}}).$promise.
  #     then(data)->
  #       console.log('jlsjls')
  $scope.move = (param)->
    Game.move({move: param}).$promise
      .then() ->
        console.log('jdfslf')
  $scope.onAudioEnd = (audio) ->
    audioElement = document.getElementById(audio)
    audioElement.pause()
    audioElement.currentTime = 0
  Pusher.logToConsole = true;

  pusher = new Pusher('30187ba71ee217eb669c', {
      encrypted: true
    });
  channel = pusher.subscribe($scope.channel)

  channel.bind 'move_success',
    (data)->
      audio.footsteps.play()
  channel.bind 'move_failed',
    (data)->
      audio.wallHit.play()
  channel.bind 'game_winner',
    (data)->
      audio.winner.play()
  channel.bind 'game_started',
    (data)->

  channel.bind 'game_finished',
    (data)->

  return
Ctrl.$inject = ['$scope', '$state', '$stateParams', 'Game']
client.controller('GameCtrl', Ctrl)
