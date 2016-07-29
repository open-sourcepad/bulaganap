module = ($resource)->

  Game = $resource "/api/game/",
    {
      
    }

  Game

module.$inject = ['$resource']
angular.module('client').factory('Game', module)
