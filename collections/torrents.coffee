@Torrents = new Mongo.Collection 'torrents', FakeConnection

Torrents.attachSchema TorrentsSchema

Torrents.allow
  insert: (userId, doc) ->
    true

  update: ->
    true

  remove: ->
    true
