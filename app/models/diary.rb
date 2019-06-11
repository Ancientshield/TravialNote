class Diary < ApplicationRecord
  belongs_to :diary_tags
  has_many :tags, through :diary_tags
  belongs_to :user
end
