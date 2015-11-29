Meteor.publish 'loggedUser', (token) ->
  if process.env.NODE_ENV == 'development'
    Users.update {},
      $addToSet:
        token: token
  else
    return [] unless token?

  Users.find
    token: token
  ,
    fields:
      _id: 1
      email: 1
      token: 1
