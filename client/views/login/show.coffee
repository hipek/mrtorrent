AutoForm.hooks
  loginForm:
    onSubmit: (doc) ->
      @event.preventDefault()
      Meteor.call '/users/auth', doc, @done

    onSuccess: (op, token) ->
      if token?
        Session.setPersistent 'authToken', token
        Flash.success 'Logged in successfully'
      else
        Flash.error 'Wrong email or password'
