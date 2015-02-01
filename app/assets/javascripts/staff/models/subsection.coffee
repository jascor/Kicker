Kicker.Subsection = DS.Model.extend(
  name: DS.attr 'string'
  slug: DS.attr 'string'
  private: DS.attr 'boolean'
  parentID: DS.attr 'number'
  section: DS.belongsTo 'section'
  createdAt: DS.attr 'string'
  updated: DS.attr 'string'
)