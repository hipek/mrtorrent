class @Fixture
  @fs: ->
    @_fs ||= Meteor.npmRequire 'fs'

  @load: (name) ->
    path = process.env.PWD + '/tests/fixtures/' + name
    @fs().readFileSync path, 'utf8'
