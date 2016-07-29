module = ($resource)->

  Game = $resource "/games/:id", {user_id: "@user_id", id: "@id"},
    {
      find_match:
        method: 'POST'
        url: "/games/find_match"
      move:
        method: 'POST'
        url: "/moves"

    }

  Game

module.$inject = ['$resource']
angular.module('client').factory('Game', module)
