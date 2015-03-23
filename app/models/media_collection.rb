=begin
  Media collections are used to generate content such
  as image slideshows/sliders. They are collection sets
  of related media content.
=end

class MediaCollection < BaseModel
  has_many :media_collection_contents, dependent: :destroy

  after_destroy :fix_articles_after_collection_destroy

  def slides
    slides = []

    self.media_collection_contents.each do |slide|
      slides.push(slide.medium)
    end

    slides
  end

  def formatted_slide_props
    collection_contents = self.media_collection_contents

    collection_content_entries = []

    collection_contents.each do |content|
      collection_content_entries.push(content.medium)
    end

    { title: self.title, totalSlides: collection_contents.count, slides: collection_content_entries }
  end

  private

  def fix_articles_after_collection_destroy
    FixArticlesAfterMediaDestroy.new.async.perform(self.id)
  end
end
