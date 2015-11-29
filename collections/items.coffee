PRIORITIES =
  0: 'off'
  1: 'low'
  2: 'normal'
  3: 'high'

@Items = new Mongo.Collection 'items', FakeConnection

Items.helpers
  humanFileSize: (size) ->
    return '0' if size == 0
    i = Math.floor( Math.log(size) / Math.log(1024) );
    ( size / Math.pow(1024, i) )
      .toFixed(1) * 1 + ' ' + ['B', 'kB', 'MB', 'GB', 'TB'][i]

  humanBytes: ->
    @humanFileSize @bytes()

  humanBytesCompleted: ->
    @humanFileSize @bytesCompleted()

  humanBytesUploaded: ->
    @humanFileSize @bytesUploaded()

  humanUpRate: ->
    @humanFileSize @upRate

  humanDownRate: ->
    @humanFileSize @downRate

  prio: ->
    PRIORITIES[@priority]

  bytes: ->
    @sizeChunks * @chunkSize

  bytesCompleted: ->
    @completedChunks * @chunkSize

  bytesUploaded: ->
    @myRatio() * @bytesDone

  isActive: ->
    @active == 1

  isComplete: ->
    @complete == 1

  status: ->
    s = 'Downloading'
    s = 'Stopped' unless @isActive()
    s = 'Complete' if @isComplete()
    s = 'Hashing' if @hashing > 0
    s

  connType: ->
    s = ''
    s = 'Leeching' if @isActive() && @connectionCurrent == 'leech'
    s = 'Seeding' if @isActive() && @connectionCurrent == 'seed'
    s

  percentComplete: ->
   "#{Math.ceil(@bytesCompleted()/@bytes() * 100)}%"

  eta: ->
    dw_r = if @downRate == 0 then 0.01 else @downRate
    (@bytes() - @bytesCompleted())/dw_r

  timeLeft: ->
    t = Math.ceil @eta()
    return t + 's' if t < 60
    return Math.ceil(t/60) + 'min' if t < 3600
    return Math.ceil(t/3600) + 'h' if t < 3600*24
    result = Math.ceil(t/(3600*24))
    if result > 100 then '--' else result + 'd'

  myRatio: ->
    @ratio/1000
