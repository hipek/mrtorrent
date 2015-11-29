class @RTorrent.Base
  @config: ->
    Meteor.settings.torrent

  @callMethod: (name, args, callback) ->
    client = new RTorrent.Service.Client(@config().host, @config().port)

    client.connect ->
      client.methodCall name, args, (data) ->
        d = new RTorrent.Service.Deserializer data
        d.parse (err, result) ->
          callback result

  constructor: (attrs) ->
    @attributes = attrs

  toDoc: ->
    _.extend {updatedAt: new Date()}, @attributes
