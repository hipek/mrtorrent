class @RTorrent.Service.Client
  constructor: (@host, @port) ->
    @net = Meteor.npmRequire 'net'
    @encoding = 'utf8'
    @stream = new @net.Stream()
    @stream.setEncoding(@encoding)
    @stream.once 'error', @onErrorCallback

  onErrorCallback: (e) ->
    # console.log e

  once: (name, method) ->
    @stream.once name, method

  write: (data) ->
    @stream.write data, @encoding

  onData: (callback) ->
    @once 'data', (data) =>
      callback data.split(/\r\n\r\n/)[1]
      @close()

  methodCall: (method, args, callback) ->
    @onData callback if callback?
    data = new RTorrent.Service.SCGIRequest method, args
    @write data.toString()

  connect: (callback) ->
    @once 'connect', callback if callback?
    @stream.connect @port, @host

  close: ->
    @stream.destroy()
