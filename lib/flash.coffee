class @Flash
  @success: (key) ->
    FlashMessages.sendSuccess key

  @error: (key) ->
    FlashMessages.sendError key

  @warning: (key) ->
    FlashMessages.sendWarning key

  @info: (key) ->
    FlashMessages.sendInfo key
