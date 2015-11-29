class @FolderFilesController extends BaseController
  template: "folderFilesIndex"

  waitOn: ->
    super
    Meteor.subscribe 'folderFiles', id: @params.folderId

  onBeforeAction: ->
    if UI._globalHelpers.currentUser()
      @next()
    else
      Flash.error 'You need to login first.'
      Router.go 'login'
