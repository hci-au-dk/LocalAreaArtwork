root = exports ? window

reloadDocInfo = ($scope) ->
    $scope.title = doc.snapshot.title
    $scope.$apply()
    
updateCount = ($scope, desc) ->
    $scope.count = 1000 - desc.snapshot.length
    $scope.$apply()
    
loadText = ($scope) ->
    reloadDocInfo $scope
    doc.on 'remoteop', (op) ->
        reloadDocInfo $scope
    
    sharejs.open doc.snapshot.description, 'text', (error, desc) ->
        elem = document.getElementById 'description'
        desc.attach_textarea elem
        updateCount $scope, desc
        
        desc.on 'change', (op) ->
            updateCount $scope, desc

@EditorCtrl = ($scope) ->
    sharejs.open 'himmelbjerget2', 'json', (error, doc) ->
        if not doc.snapshot?
            newDoc = {
                'title': 'Himmelbjerget'
                'artist': 'Unknown artist'
                'year': 'Unknown'
                'material': 'Oil on canvas'
                'description': 'description'
            }
            doc.set newDoc, (error, rev) ->
                if error?
                    console.log error
                else
                    root.doc = doc
                    loadText $scope
        else
            root.doc = doc
            loadText $scope