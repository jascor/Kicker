require 'fileutils'

class ArticleType < BaseModel
  include SanitizationHelper

  has_many :articles

  after_create :update_layout_file

  after_update :validate_layout_file

  after_destroy :delete_layout_file

  def layout_filename(old = false)
    "#{sanitize_filename(old && name_changed? ? name_was : name)}-#{id}.html.haml"
  end

  def layout_file_location
    "layouts/article_types/#{layout_filename}"
  end

private

  def layout_file_path
    Rails.root.join('app', 'views', 'layouts', 'article_types').to_s
  end

  def validate_layout_file
    if (name_changed? && layout_changed?) || layout_changed?
      update_layout_file
    elsif name_changed?
      change_layout_filename
    end
  end

  def layout_file_exists?
    Rails.root.join('app', 'views', 'layouts', 'article_types', layout_filename).exist?
  end

  def update_layout_file
    unless Rails.root.join('app', 'views', 'layouts', 'article_types').exist?
      FileUtils.mkdir_p(layout_file_path)
    end

    delete_layout_file if layout_file_exists?
    delete_layout_file(true) if name_changed?

    File.open("#{layout_file_path}/#{layout_filename}", 'w+') do |f|
      f.write(layout)
    end
  end

  def change_layout_filename
    update_layout_file unless layout_file_exists?

    File.rename("#{layout_file_path}/#{layout_filename(true)}", "#{layout_file_path}/#{layout_filename}")
  end

  def delete_layout_file(old = false)
    return nil unless layout_file_exists?

    File.delete("#{layout_file_path}/#{old ? layout_filename(true) : layout_filename}")
  end
end