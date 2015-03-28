=begin
  This model represents the actual content that each section
  block (on the section pages) contains. Content is not
  limited to articles only, but also other types of posts
  such as image slideshows and videos.
=end

class SectionPageSectionContent < ActiveRecord::Base
  belongs_to :section_page_section
  belongs_to :article
  belongs_to :media_collection
end
