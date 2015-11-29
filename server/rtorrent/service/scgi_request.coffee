class RTorrent.Service.SCGIRequest
  constructor: (@method, @params) ->
    @xmlrpc = Meteor.npmRequire 'xmlrpc'

  header: (content) ->
    "CONTENT_LENGTH\0#{content.length}\0" +
    "SCGI#{"\0"}1\0REQUEST_METHOD\0#{RTorrent.Service.METHOD}\0" +
    "REQUEST_URI\0#{RTorrent.Service.URI}\0"

  xml: () ->
    @xmlrpc.Serializer.serializeMethodCall @method, @params

  toString: ->
    xml = @xml()
    h = @header(xml)
    "#{h.length}:#{h},#{xml}"
