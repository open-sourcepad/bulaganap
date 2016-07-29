Ctrl = ($scope, $state) ->
  $scope.startGame = ->
    $state.go('game')

Ctrl.$inject = ['$scope', '$state']
client.controller('HomeCtrl', Ctrl)
