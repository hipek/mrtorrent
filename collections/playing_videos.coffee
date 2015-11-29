@PlayingVideos = new Mongo.Collection 'playing_videos', FakeConnection

PlayingVideos.checkPlaying = ->
  shell = Meteor.npmRequire 'shelljs'
  opts = {silent: true}
  str = shell.exec('ps ax | grep "mpv\\\\|mplayer" | grep -v grep', opts).output
  if str.length > 0
    @setName str.split('/').pop()

PlayingVideos.setName = (name) ->
  @upsert
    _id: '1'
  ,
    name: name
