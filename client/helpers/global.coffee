UI.registerHelper 'currentUser', ->
  Users.findOne
    token: Session.get 'authToken'
