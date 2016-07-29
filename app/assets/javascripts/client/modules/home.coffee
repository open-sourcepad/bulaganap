Ctrl = ($scope, $state, Game) ->
  pusher = new Pusher '30187ba71ee217eb669c',
    encrypted: true

  $scope.startGame = ->
    Game.find_match().$promise.
      then (data) ->
        $state.go('game', {channel: "player_#{data.player_id}_channel", id: data.player_id})

Ctrl.$inject = ['$scope', '$state', 'Game']
client.controller('HomeCtrl', Ctrl)
