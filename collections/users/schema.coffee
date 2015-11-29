@UsersSchema = new SimpleSchema
  email:
    type: String
  password:
    type: String
  token:
    type: [String]
    optional: true
