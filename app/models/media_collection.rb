=begin
  Media collections are used to generate content such
  as image slideshows/sliders. They are collection sets
  of related media content.
=end

class MediaCollection < BaseModel
  has_many :media_collection_contents
  has_many :section_page_section_contents
end
