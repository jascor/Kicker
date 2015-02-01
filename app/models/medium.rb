=begin
  This model actually represents media content.
=end

class Medium < BaseModel
  has_many :media_collection_contents
end
