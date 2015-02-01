class Section < BaseModel
  include SanitizationHelper

  has_many :articles
  has_many :subsections, class_name: 'Section', foreign_key: 'parent_id', dependent: :destroy
  has_many :section_page_sections

  belongs_to :parent_category, class_name: 'Section'

  after_save :create_slug

private

  def create_slug
    update_columns(slug: make_slug(name))
  end
end