Ctrl = ($scope, $state, $stateParams, Game) ->
  $scope._prev = null
  $scope._current= null

  $scope.direction = null
  audio =
    waiting: document.getElementById('waiting')
    started: document.getElementById('started')
    footsteps: document.getElementById('footsteps')
    wallHit: document.getElementById('wallHit')
    winner: document.getElementById('winner')
    loser: document.getElementById('loser')
    near: document.getElementById('near')

  $scope.playerId = $stateParams.id
  $scope.channel = $stateParams.channel
  $scope.gameId = $stateParams.game_id
  $scope.gameStatus = ""
  $scope.moveDisabled = false
  audio.waiting.onended = ()->
    audio.waiting.pause()
    audio.waiting.currentTime = 0
    audio.waiting.play()

  audio.started.onended = ()->
    audio.started.pause()
    audio.started.currentTime = 0
    audio.started.play()

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

  $scope.move = (param)->
    if !$scope.moveDisabled && $scope.gameStatus == 'started'
      $scope.moveDisabled = true
      Game.move({move: param}).$promise
        .then ->
          null
        .finally ->
          $scope.moveDisabled = false

  for audioType in ['wallHit', 'footsteps']
    audioElement = document.getElementById(audioType)
    audioElement.addEventListener 'ended', ->
      audioElement.pause()
      audioElement.currentTime = 0

  # for audioType in ['waiting', 'started', 'near', 'winner', 'loser']
  #   audioElement = document.getElementById(audioType)
  #   audioElement.pause()
  #   audioElement.addEventListener 'ended', ->
  #     audioElement.currentTime = 0
  #     audioElement.play()
  audio.waiting.onended = ->
    audio.waiting.currentTime = 0
    audio.waiting.play()
  audio.started.onended = ->
    audio.started.currentTime = 0
    audio.started.play()
  audio.winner.onended = ->
    audio.winner.currentTime = 0
    audio.winner.play()
  audio.started.onended = ->
    audio.started.currentTime = 0
    audio.started.play()
  audio.loser.onended = ->
    audio.loser.currentTime = 0
    audio.loser.play()
  audio.near.onended = ->
    audio.near.currentTime = 0
    audio.near.play()

  Pusher.logToConsole = true;

  pusher = new Pusher('30187ba71ee217eb669c', {
      encrypted: true
    });
  channel = pusher.subscribe($scope.channel)

  channel.bind 'move_success',
    (data)->
      audio.footsteps.play()
      console.log(audio.footsteps)
  channel.bind 'move_failed',
    (data)->
      audio.wallHit.play()
  channel.bind 'near_goal',
    (data)->
      if data.near && !isAudioPlaying(audio.near)
        audio.near.play()
      else if !data.near
        audio.near.pause()
  channel.bind 'game_started',
    (data)->
      $scope.gameStatus = "started"
      playBackgroundAudio()
  channel.bind 'game_finished',
    (data)->
      audio.near.pause()
      if data.win
        audio.winner.play()
      else
        audio.loser.play()
      setTimeout(->
        $state.go('home')
      , 10000)
      return




  isAudioPlaying =(currentAudio)->
    return currentAudio.currentTime > 0 && !currentAudio.paused
  getGameStatus =->
    Game.get({id: $scope.gameId}).$promise
      .then (data) ->
        $scope.gameStatus = data.status
        playBackgroundAudio()


  playBackgroundAudio =->
    if $scope.gameStatus == 'in_queue'
      audio.started.pause()
      audio.waiting.play()
    else if $scope.gameStatus == 'started'
      audio.waiting.pause()
      audio.started.play()
  getGameStatus()
  return
Ctrl.$inject = ['$scope', '$state', '$stateParams', 'Game']
client.controller('GameCtrl', Ctrl)
