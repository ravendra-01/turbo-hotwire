class Post < ApplicationRecord
  has_rich_text :content
  belongs_to :user

  validates_presence_of :title, :content
end