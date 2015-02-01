Kicker.Medium = DS.Model.extend(
  filename: DS.attr 'string'
  title: DS.attr 'string'
  credit: DS.attr 'string'
  mimeType: DS.attr 'string'
  S3Key: DS.attr 'string'
  link: DS.attr 'string'
  secureLink: DS.attr 'string'
  caption: DS.attr 'string'
  userId: DS.attr 'string'
  createdAt: DS.attr 'string'
  updatedAt: DS.attr 'string'
)