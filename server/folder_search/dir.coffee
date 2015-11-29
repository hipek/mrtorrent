class FolderSearch.Dir
  fs: Meteor.npmRequire 'fs'

  videos: 'mkv|avi|mp4'
  subs:   'srt|txt'

  constructor: (@subdir = null) ->
    @baseDir = Meteor.settings['torrent'].dest_dir
    @subdir ||= @baseDir
    @videosRegexp = new RegExp @videos
    @subsRegexp = new RegExp @subs

  findAll: ->
    list = []
    pattern = "#{@subdir}/*"
    @fs.readdirSync(@subdir).forEach (file) =>
      f = [@subdir, file].join '/'
      doc = {_id: '0', path: @baseDir}
      @pathNames(@basePath(f)).forEach (name) =>
        doc = @buildDoc name, doc
        list.push doc if @validItem(doc)
    @filterList list

  filterList: (list) ->
    result = []
    list.forEach (doc) ->
      if doc.isSub
        video = _.findWhere list, subId: doc.subId
        video.subs ||= []
        video.subs.push doc
      else
        result.push doc
    result

  validItem: (doc) ->
    return true unless doc.isFile
    @isSub(doc.name) || @isVideo(doc.name)

  buildDoc: (name, parent, path = null) ->
    path ||= [parent.path, name].join('/')
    result =
      path: path
      name: name
      _id: @md5(name + parent._id)
      subId: @md5(@basename(name) + parent._id)
      parentId: parent._id
      isFile: @isFile(path)
      isSub:  @isSub(name)
      subs: []

  md5: (str) ->
    Meteor.npmRequire('crypto')
      .createHash('md5')
      .update(str)
      .digest('hex')

  pathNames: (name) ->
    _.compact name.split('/')

  isFile: (path) ->
    !@fs.statSync(path).isDirectory()

  isSub: (name) ->
    !!name.match @subsRegexp

  isVideo: (name) ->
    !!name.match @videosRegexp

  basePath: (fullName) ->
    fullName.replace @baseDir, ''

  basename: (name) ->
    list = name.split(/\./)
    list.pop()
    list.join('.')
