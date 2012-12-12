root = exports ? window

reloadDocInfo = () ->
    $('#title').empty()
    $('#title').append doc.snapshot.title
    $('#artist').empty()
    $('#artist').append doc.snapshot.artist
    $('#material').empty()
    $('#material').append doc.snapshot.material
    
loadText = () ->
    reloadDocInfo()
    doc.on 'remoteop', (op) ->
        reloadDocInfo()
    
    sharejs.open doc.snapshot.description, 'text', (error, desc) ->
        elem = document.getElementById 'description'
        console.log elem
        desc.attach_textarea elem

$(document).ready () ->
    sharejs.open 'himmelbjerget', 'json', (error, doc) ->
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
                    loadText()
        else
            root.doc = doc
            loadText()