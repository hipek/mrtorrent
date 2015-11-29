class @Player
  shell: Meteor.npmRequire 'shelljs'

  constructor: (@file) ->

  start: ->
    @stop()
    return unless @file?
    @playFile()

  stop: ->
    @cmd "xdotool key Escape && xdotool key Escape"

  pause: ->
    @cmd "xdotool key space"

  fastForward: ->
    @cmd "xdotool key Up"

  fastBackward: ->
    @cmd "xdotool key Down"

  forward: ->
    @cmd "xdotool key Right"

  backward: ->
    @cmd "xdotool key Left"

  cmd: (command, opts = {}) ->
    @shell.exec(command, silent: true, async: true).output || 'ok'

  playFile: (path) ->
    if !!@file.path.match /\.avi/
      @mpv()
    else
      @mplayer()

  mplayer: ->
    @cmd "mplayer '#{@file.path}' &"

  mpv: ->
    @cmd "mpv '#{@file.path}' &"
