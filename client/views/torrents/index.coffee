Template.torrentsIndex.helpers
  items: ->
    Items.find {},
      sort:
        name: 1

Template.torrentsIndex.events
  "click a#newTorrent": (e) ->
    e.preventDefault()
    AntiModals.overlay 'torrentsNew'

  "click form#torrentsForm button": (e) ->
    e.preventDefault()
    button = $(e.target)
    action = $(e.target).val()
    ids = _.map button.parents('form').find('input:checked'), (input) ->
      $(input).val()

    Meteor.call '/torrents/action', action: action, ids: ids
