@Users = new Mongo.Collection 'users', FakeConnection

Users.attachSchema UsersSchema

Users.auth = (email, password) ->
  Users.findOne
    email: email
    password: password
