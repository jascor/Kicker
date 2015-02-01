=begin
  The class name is confusing, but this model represents the
  individual content sections on a section page. That is, the
  blocks of content that contain articles. It is not to be
  confused with the actual sections themselves.

  Editors can dynamically add these content blocks (sections)
  to their section pages and place articles within them.
  There are different types of content sections, each of
  which is documented below.

  @todo Document all valid content sections
=end

class SectionPageSection < BaseModel
  belongs_to :section
end
