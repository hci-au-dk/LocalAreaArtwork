root = exports ? window

reloadDocInfo = () ->
    $('#title').empty()
    $('#title').append doc.snapshot.title
    $('#artist').empty()
    $('#artist').append doc.snapshot.artist
    $('#year').empty()
    $('#year').append doc.snapshot.year
    $('#material').empty()
    $('#material').append doc.snapshot.material
    
reloadDescription = (text) ->
    html = markDownConverter.makeHtml text
    $('#description').empty()
    $('#description').append html

loadText = () ->
    reloadDocInfo()
    doc.on 'remoteop', (op) ->
        reloadDocInfo()
        
    sharejs.open doc.snapshot.description, 'text', (error, desc) ->
        reloadDescription desc.snapshot
        desc.on 'remoteop', (op) ->
            reloadDescription(desc.snapshot)

$(document).ready () ->
    root.markDownConverter = new Markdown.Converter()
    sharejs.open 'artwork', 'json', (error, doc) ->
        if not doc.snapshot?
            newDoc = {
                'title': 'The Sick Child'
                'artist': 'Edvard Munch'
                'year': '1885'
                'material': 'Oil on canvas'
                'description': 'artworkDescription'
            }
            doc.set newDoc, (error, rev) ->
                if error?
                    console.log error
                else
                    root.doc = doc
                    console.log "HELLO"
                    loadText()
        else
            root.doc = doc
            loadText()