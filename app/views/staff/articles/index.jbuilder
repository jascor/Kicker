json.articles do
  json.array! @articles do |article|
    json.id article.id
    json.user_id article.user_id
    json.featured_media_id article.featured_media_id
    json.article_type_id article.article_type_id
    json.section_id article.section_id
    json.subsection_id article.subsection_id
    json.published article.published
    json.private article.private
    json.disable_comments article.disable_comments
    json.writer_name article.writer_name
    json.raw_writer_name article.raw_writer_name
    json.headline article.headline
    json.subheading article.subheading
    json.summary article.summary
    json.contents article.contents
    json.raw_contents article.raw_contents
    json.slug article.slug
    json.section article.section
    json.subsection article.subsection
    json.article_type article.article_type
    json.published_at article.published_at
    json.created_at article.created_at
    json.updated_at article.updated_at
  end
end

json.meta do
  json.total_pages @articles.total_pages
end