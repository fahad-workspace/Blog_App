class Article < ActiveRecord::Base

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  validates :title,
            :presence => {:message => ": Can't be blank!"},
            :length => {:minimum => 5, :message => ": Must be atleast 5 characters!"}
  validates :text,
            :presence => {:message => ": Can't be blank!"},
            :length => {:minimum => 15, :message => ": Must be atleast 15 characters!"}

end