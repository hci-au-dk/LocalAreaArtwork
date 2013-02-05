// Generated by CoffeeScript 1.3.1
(function() {
  var socket;

  socket = io.connect('http://localhost');

  this.StubCtrl = function($scope) {
    $scope.inProximityOfFoo = function() {
      return socket.emit('inProximity', {
        locations: ['foo']
      });
    };
    $scope.inProximityOfBar = function() {
      return socket.emit('inProximity', {
        locations: ['bar']
      });
    };
    $scope.noProximity = function() {
      return socket.emit('inProximity', {
        locations: []
      });
    };
    return $scope.twoInProximity = function() {
      return socket.emit('inProximity', {
        locations: ['foo', 'bar']
      });
    };
  };

}).call(this);