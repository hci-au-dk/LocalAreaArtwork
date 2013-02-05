socket = io.connect 'http://localhost'

@StubCtrl = ($scope) ->
    $scope.inProximityOfFoo = () ->
        socket.emit 'inProximity', { locations: ['foo'] }
        
    $scope.inProximityOfBar = () ->
        socket.emit 'inProximity', { locations: ['bar'] }
        
    $scope.noProximity = () ->
        socket.emit 'inProximity', { locations: [] }
        
    $scope.twoInProximity = () ->
        socket.emit 'inProximity', { locations: ['foo', 'bar'] }
    