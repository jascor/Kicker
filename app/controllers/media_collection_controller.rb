class MediaCollectionController < ApplicationController
  def show
    @media = MediaCollection.first
  end

  def self.controller_path
    'components/media_collection'
  end
end