class @RTorrent.Service.Deserializer
  constructor: (@xml) ->
    @xml2js = Meteor.npmRequire 'xml2js'

  parse: (callback) ->
    @xml2js.parseString @xml, (err, data) =>
      if err
        callback err, null
      else
        callback err, @parseParams data.methodResponse.params

  parseParams: (params) ->
    @parseValue params.shift().param.shift().value.shift()

  parseValue: (value) ->
    key = @getKey value
    switch key
      when 'array'
        @parseArray value[key]
      when 'i8', 'int', 'i4'
        parseInt value[key].shift()
      else
        value[key].shift()

  parseArray: (array) ->
    _.map array.shift().data.shift().value, (val) =>
      @parseValue(val)

  getKey: (node) ->
    _.keys(node).shift()
