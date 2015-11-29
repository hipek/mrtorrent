@TorrentsSchema = new SimpleSchema
  url:
    type: String
    optional: true
  torrentId:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'file'
        multiple: 'multiple'
