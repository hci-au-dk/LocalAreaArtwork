socket = io.connect 'http://localhost'

showArtwork = ($scope) ->
    $scope.showMap = false
    $scope.showPopUp = false
    $scope.showArtwork = true
    
showMap = ($scope) ->
    $scope.showMap = true
    $scope.showPopUp = false
    $scope.showArtwork = false
    
showPopUp = ($scope) ->
    $scope.showPopUp = true
    
hidePopUp = ($scope) ->
    $scope.showPopUp = false

@IndexCtrl = ($scope) ->
    showMap $scope
    
    $scope.availableLocations = []
    
    socket.on 'inProximity', (data) ->
        if data.locations.length == 1
            if not $scope.location?
                $scope.location = data.locations[0]
                showArtwork $scope
            else if $scope.location != data.locations[0]
                showPopUp $scope
        else if data.locations.length == 0 and not $scope.location?
            showMap $scope
        else if data.locations.length == 2
            showPopUp $scope
        $scope.availableLocations = data.locations
        $scope.$apply()
        
    $scope.selectLocation = (location) ->
        $scope.location = location
        showArtwork $scope
        
    $scope.closeLocation = () ->
        $scope.location = null
        showMap $scope
        
@ArtworkController = ($scope) ->

@MapController = ($scope) ->

@PopUpController = ($scope) ->
    