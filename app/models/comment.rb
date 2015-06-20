class Comment < ActiveRecord::Base

  belongs_to :photo

  validates_presence_of :words

end
