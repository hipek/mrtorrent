class Subtitles.Downloader
  constructor: (@file, @ext = 'srt') ->
    @subs = Meteor.npmRequire 'napi-js'
    # @subs = {downloadSubtitles: (-> {then: (fn) -> fn('/as/test.srt')}), LANGUAGE: {}}
    @fs   = Meteor.npmRequire 'fs'


  perform: (success, error) ->
    f1 = (obj) =>
      @rename obj
      success @destFile()

    f2 = (obj) =>
      # console.log "err: " + obj
      error obj.toString()

    f3 = (obj) ->
      # console.log "prog: " + obj

    @subs.downloadSubtitles(
      @file,
      @subs.LANGUAGE.POLISH
    ).then f1, f2, f3

  rename: (source) ->
    @fs.renameSync source, @destFile()

  destFile: ->
    parts = @file.split('.')
    parts.pop()
    parts.push @ext
    parts.join('.')
