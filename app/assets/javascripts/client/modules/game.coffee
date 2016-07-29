Ctrl = ($scope, $state) ->
  $scope._prev = null
  $scope._current= null

  $scope.direction = null

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

  return

Ctrl.$inject = ['$scope', '$state']
client.controller('GameCtrl', Ctrl)
