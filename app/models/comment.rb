class Comment < ActiveRecord::Base
  belongs_to :article
  validates :commenter,
            :presence => {:message => ": Can't be blank!"}
  validates :body,
            :presence => {:message => ": Can't be blank!"}
end
