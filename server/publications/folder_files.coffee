Meteor.publish 'folderFiles', (data) ->
  ff = FolderFiles.findOne _id: data.id

  FolderFiles.remove({})

  dir = new FolderSearch.Dir(ff?.path)
  dir.findAll().forEach (doc) ->
    FolderFiles.upsert _id: doc._id, doc

  FolderFiles.find {},
    fields:
      _id: 1
      name: 1
      parentId: 1
      isFile: 1
      isSub: 1
      subId: 1
      subs: 1
