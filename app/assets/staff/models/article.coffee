Kicker.Article = DS.Model.extend(
  userID: DS.attr 'number'
  featuredMediaID: DS.attr 'number'
  articleTypeID: DS.attr 'number'
  sectionID: DS.attr 'number'
  subsectionID: DS.attr 'number'
  published: DS.attr 'boolean', defaultValue: false
  private: DS.attr 'boolean', defaultValue: true
  disableComments: DS.attr 'boolean', defaultValue: false
  writerName: DS.attr 'string'
  rawWriterName: DS.attr 'string'
  headline: DS.attr 'string'
  subheading: DS.attr 'string'
  summary: DS.attr 'string'
  contents: DS.attr 'string'
  rawContents: DS.attr 'string'
  slug: DS.attr 'string'
  section: DS.belongsTo 'section'
  subsection: DS.belongsTo 'subsection'
  articleType: DS.belongsTo 'articleType'
  publishedAt: DS.attr 'string'
  createdAt: DS.attr 'string'
  updatedAt: DS.attr 'string'
)