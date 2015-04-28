module Staff
  class StaffController < ApplicationController
    #before_filter :use_dummy_session

    skip_before_action :fastly_cache_until_purged

    layout 'staff'

    def index

    end

    private

    #def use_dummy_session
    #  return unless request.format.json?
    #
    #  env['rack.session'] = {}
    #end
  end
end