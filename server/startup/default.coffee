Meteor.startup ->
  yaml = Meteor.npmRequire 'js-yaml'
  fs   = Meteor.npmRequire 'fs'

  config = yaml.safeLoad fs.readFileSync(
    "#{process.env.PWD}/server/config.yml", 'utf8'
  )

  Meteor.settings['torrent'] ||= config[process.env.NODE_ENV]

  Meteor.settings.torrent.users.forEach (user) ->
    Users.insert
      email: user.email
      password: user.password

  PlayingVideos.checkPlaying()
