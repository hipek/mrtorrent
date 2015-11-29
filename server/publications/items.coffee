eachTorrentDoc = (func) ->
  RTorrent.Item.all (items) ->
    _.each items, (item) ->
      func item.toDoc()

updateTorrentItems = ->
  eachTorrentDoc (doc) ->
    Items.upsert doc._id, doc

Meteor.publish 'torrentItems', ->
  updateTorrentItems

  Items.find {},
    fields:
      _id: 1
      name: 1
      hashing: 1
      ratio: 1
      active: 1
      bytesLeft: 1
      bytesSize: 1
      bytesDone: 1
      downRate: 1
      upRate: 1
      priority: 1
      connectionCurrent: 1
      complete: 1
      sizeChunks: 1
      chunkSize: 1
      completedChunks: 1
      updatedAt: 1

Meteor.publish 'torrentItemsStart', ->
  funId = Meteor.setInterval updateTorrentItems, 2000

  @ready()

  @onStop ->
    Meteor.clearInterval funId
