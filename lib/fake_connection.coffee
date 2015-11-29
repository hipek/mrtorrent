@FakeConnection = if Meteor.isServer
  connection: null
else
  {}
