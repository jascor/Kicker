module SanitizationHelper
  def sanitize_filename(name)
    fn = name.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m

    fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }

    fn.join '.'
  end

  def make_slug(string)
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end