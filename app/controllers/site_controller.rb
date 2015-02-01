class SiteController < ApplicationController
  def index
    @media = MediaCollection.first
  end
end