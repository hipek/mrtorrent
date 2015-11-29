Meteor.publish 'playingVideo', ->
  PlayingVideos.find {},
    fields:
      name: 1
      _id: 1
