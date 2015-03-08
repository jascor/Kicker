json.section do
  json.id @section.id
  json.name @section.name
  json.slug @section.slug
  json.fa_icon @section.fa_icon
  json.private @section.private
  json.section_page_sections do
    json.array! @section.section_page_sections do |page_section|
      json.id page_section.id
      json.title page_section.title
      json.subtitle page_section.subtitle
      json.type_name page_section.type_name
      json.type_slug page_section.type_slug
      json.position page_section.position
      json.section_id page_section.section_id
      json.static page_section.static
      json.section_page_section_contents page_section.section_page_section_contents
      json.created_at page_section.created_at.to_s
      json.updated_at page_section.updated_at.to_s
    end
  end
  json.created_at @section.created_at.to_s
  json.updated_at @section.updated_at.to_s
end