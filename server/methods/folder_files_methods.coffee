addSub = (doc) ->
  FolderFiles.update
    subId: doc.subId
  ,
    $addToSet:
      subs: doc

Meteor.methods
  '/folder_files/subfetch': (data) ->
    Future = Meteor.npmRequire 'fibers/future'

    @unblock()

    future = new Future()

    ff  = FolderFiles.findOne data.id
    dir = new FolderSearch.Dir()

    sub = new Subtitles.Downloader(ff.path)
    sub.perform (subFile) ->
      name = dir.pathNames(subFile).pop()
      doc = dir.buildDoc name, {_id: ff.parentId}, subFile
      addSub doc
      future.return 'Subtitles downloaded successfully'
    , (err) ->
      future.return err

    future.wait()

Meteor.methods
  '/folder_files/player-action': (data) ->
    ff  = FolderFiles.findOne data.id

    @unblock()

    if data.action == 'start'
      PlayingVideos.setName ff.name
    else if data.action == 'stop'
      PlayingVideos.remove({})

    player = new Player(ff)
    player[data.action]()
