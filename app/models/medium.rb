=begin
  This model actually represents media content.
=end

class Medium < BaseModel
  has_many :media_collection_contents

  after_update :check_for_no_longer_pending

  private

  def check_for_no_longer_pending
    if self.pending_initial_edit
      if self.title || self.credit || self.caption
        self.update({pending_initial_edit: false})
      end
    end
  end
end
