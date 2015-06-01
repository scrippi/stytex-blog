class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy

  def get_date
    (self.release_date.nil?) ? self.created_at : self.release_date
  end
end
