class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :user
  def get_date
    (self.release_date.nil?) ? self.created_at : self.release_date
  end

  def get_comments
    self.comments.where(:permitted => true).order(created_at: :desc)
  end
end
