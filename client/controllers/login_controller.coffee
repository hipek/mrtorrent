class @LoginController extends BaseController
  template: "loginShow"

  onBeforeAction: ->
    if UI._globalHelpers.currentUser()
      Router.go 'torrents'
    else
      @next()
