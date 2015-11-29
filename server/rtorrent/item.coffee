class @RTorrent.Item extends RTorrent.Base
  methods:
    creation_date: 'creationDate'
    free_diskspace: 'freeDiskspace'
    base_filename: 'baseFilename'
    base_path: 'path'
    directory: 'directory'
    message: 'message'
    hash: '_id'
    hashing: 'hashing'
    name: 'name'
    left_bytes: 'bytesLeft'
    size_bytes: 'bytesSize'
    chunk_size: 'chunkSize'
    size_chunks: 'sizeChunks'
    completed_chunks: 'completedChunks'
    bytes_done: 'bytesDone'
    'down.rate': 'downRate'
    'up.rate': 'upRate'
    priority: 'priority'
    connection_current: 'connectionCurrent'
    complete: 'complete'
    local_id: 'localId'
    ratio: 'ratio'
    is_active: 'active'
    is_multi_file: 'multiFile'

  @getMethods: ->
    list = _.chain(@::methods).keys().map (name) ->
      "d.#{name}="
    .value()
    list.unshift 'main'
    list.unshift ''
    list

  @all: (callback) ->
    @callMethod 'd.multicall2', @getMethods(), (data) =>
      callback _.map data, (list) => @build list

  @build: (values) ->
    attrs = {}
    _.chain(@::methods).values().map (name, i) ->
      attrs[name] = values[i]
    new RTorrent.Item attrs

  @action: (name, id) ->
    @callMethod "d.#{name}", [id], Meteor.bindEnvironment (data) =>
      Items.remove _id: id if name == 'erase'
