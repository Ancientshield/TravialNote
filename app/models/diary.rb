class Diary < ApplicationRecord
  has_many :diary_tags
  has_many :tags, through: :diary_tags
  belongs_to :user
end
