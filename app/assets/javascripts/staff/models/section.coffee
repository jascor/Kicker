Kicker.Section = DS.Model.extend(
  name: DS.attr 'string'
  slug: DS.attr 'string'
  private: DS.attr 'boolean'
  subsections: DS.hasMany 'subsection'
  articles: DS.hasMany 'article'
  parent: DS.belongsTo 'section'
  createdAt: DS.attr 'string'
  updatedAt: DS.attr 'string'
)