Meteor.methods
  '/torrents/insert': (file) ->
    fs = Meteor.npmRequire 'fs'

    path = [
      Meteor.settings.torrent.path,
      file.info.name
    ].join '/'

    fs.writeFile path, file.data, 'binary', (err) ->
      throw err if err

Meteor.methods
  '/torrents/action': (data) ->
    _.each data.ids, (id) ->
      RTorrent.Item.action data.action, id
