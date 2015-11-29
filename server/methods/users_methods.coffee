hashPassword = (password) ->
  SHA256 password

Meteor.methods
  '/users/auth': (doc) ->
    user = Users.auth doc.email, hashPassword doc.password

    return unless user?

    token = Random.id(40)
    Users.update
      _id: user._id
    ,
      $addToSet:
        token: token
    token
