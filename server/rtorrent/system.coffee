class @RTorrent.System extends RTorrent.Base
  methods:
    'system.listMethods': 'listMethods'
    view_list: 'listViews'
    get_upload_rate: 'uploadRate'
    get_download_rate: 'downloadRate'
    get_up_rate: 'upRate'
    get_down_rate: 'downRate'
    set_download_rate: 'setDownloadRate'
    set_upload_rate: 'setUploadRate'

  @getAll: (callback) ->
    @callMethod 'system.multicall', ['get_up_rate', 'get_down_rate'], (data) =>
      callback data
