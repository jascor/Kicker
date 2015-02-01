class MediaCollectionContent < ActiveRecord::Base
  belongs_to :media_collection
  belongs_to :medium
end
