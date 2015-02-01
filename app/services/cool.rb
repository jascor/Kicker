class Cool
  include ActionView::Context
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include React::Rails::ViewHelper

  def damn
    react_component('MediaCollection', {}, { prerender: true })
  end
end