AutoForm.hooks
  insertTorrentForm:
    onSubmit: (data) ->
      @event.preventDefault()
      input = $(@event.target)
        .find('input[type=file]').get(0)
      uploader = new FileUpload input

      return @done() unless uploader.hasFile()

      uploader.upload (data) =>
        Meteor.call '/torrents/insert', data, @done

    onSuccess: (operation, doc) ->
      Flash.success 'Torrent(s) added.'
      AntiModals.dismissAll()
