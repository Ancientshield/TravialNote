class Tag < ApplicationRecord
  belongs_to :user
  has_many :diary_tags
  has_many :diaries, through: :diary_tags
end