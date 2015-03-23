=begin
  This model actually represents media content.
=end

class Medium < BaseModel
  has_many :media_collection_contents, dependent: :destroy

  after_update :check_for_no_longer_pending

  after_destroy :fix_articles_after_medium_destroy

  private

  def check_for_no_longer_pending
    if self.pending_initial_edit
      if self.title || self.credit || self.caption
        self.update({pending_initial_edit: false})
      end
    end
  end

  def fix_articles_after_medium_destroy
    FixArticlesAfterMediaDestroy.new.async.perform(self.id)
  end
end
