root = exports ? window

reloadDocInfo = ($scope) ->
    $scope.artwork.title = doc.snapshot.title
    $scope.artwork.artist = doc.snapshot.artist
    $scope.artwork.material = doc.snapshot.material
    $scope.artwork.year = doc.snapshot.year
    $scope.$apply()
    
reloadDescription = ($scope, text) ->
    #html = markDownConverter.makeHtml text
    text = text.replace /(<([^>]+)>)/ig, ""
    $scope.artwork.description = text
    $scope.$apply()

loadText = ($scope) ->
    reloadDocInfo($scope)
    doc.on 'remoteop', (op) ->
        reloadDocInfo($scope)
        
    sharejs.open doc.snapshot.description, 'text', (error, desc) ->
        reloadDescription $scope, desc.snapshot
        desc.on 'remoteop', (op) ->
            reloadDescription $scope, desc.snapshot

@DescriptionCtrl = ($scope) ->
    window.$scope = $scope
    $scope.artwork = {}
    sharejs.open 'himmelbjerget2', 'json', (error, doc) ->
        if not doc.snapshot?
            newDoc = {
                'title': 'Himmelbjerget',
                'artist': 'Unknown artist',
                'year': '1898',
                'material': 'Oil on canvas',
                'description': 'description'
            }
            doc.set newDoc, (error, rev) ->
                if error?
                    console.log error
                else
                    root.doc = doc
                    loadText($scope)
        else
            root.doc = doc
            loadText($scope)