Template.navbarRight.helpers
  currentVideoName: ->
    name = PlayingVideos.findOne()?.name
    if name
      "Now playing: #{name}"

Template.navbarRight.events
  "click ul li button[data-player-action]": (e) ->
    e.preventDefault()

    Meteor.call '/folder_files/player-action',
      id: $(e.currentTarget).val()
      action: $(e.currentTarget).attr('data-player-action')
