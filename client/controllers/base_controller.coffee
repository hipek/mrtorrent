class @BaseController extends RouteController
  waitOn: ->
    Meteor.subscribe 'loggedUser', Session.get 'authToken'
