Template.folderFilesIndex.helpers
  folderFiles: ->
    FolderFiles.find
      parentId: Router.current().params.folderId
    ,
      sort:
        isFile: 1
        name: 1

  backFolderId: ->
    FolderFiles.findOne
      _id: Router.current().params.folderId
    ?.parentId

  backFolderName: ->
    '<< ' + FolderFiles.findOne
      _id: Router.current().params.folderId
    ?.name

  showBackButton: ->
    FolderFiles.findOne
      _id: Router.current().params.folderId

  canDownloadSub: ->
    @isFile && !@isSub

Template.folderFilesIndex.events
  "click a[data-item-action=show]": (e) ->
    e.preventDefault()
    Session.set 'parentId', $(e.currentTarget).attr('data-item-id')

  "click form#folderFilesForm button[data-action=subfetch]": (e) ->
    e.preventDefault()

    Meteor.call '/folder_files/subfetch', id: $(e.currentTarget).val(), (error, result) ->
      if error?
        Flash.error error
      else
        Flash.success result

  "click form#folderFilesForm button[data-player-action]": (e) ->
    e.preventDefault()

    Meteor.call '/folder_files/player-action',
      id: $(e.currentTarget).val()
      action: $(e.currentTarget).attr('data-player-action')
