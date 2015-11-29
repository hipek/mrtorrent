@LoginSchema = new SimpleSchema
  email:
    type: String

  password:
    type: String
    autoform:
      afFieldInput:
        type: 'password'
