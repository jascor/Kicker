class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :exception

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :configure_permitted_parameters, if: :devise_controller?

  def escape_elastic_search_query(query)
    query.gsub(/([#{Regexp.escape('\\+-&|!(){}[]^~*?:/')}])/, '\\\\\1')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end
end