class @TorrentsController extends BaseController
  template: "torrentsIndex"

  waitOn: ->
    super
    Meteor.subscribe 'torrentItemsStart'
    Meteor.subscribe 'torrentItems'

  onBeforeAction: ->
    if UI._globalHelpers.currentUser()
      @next()
    else
      Flash.error 'You need to login first.'
      Router.go 'login'
