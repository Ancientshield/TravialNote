class Tag < ApplicationRecord
  belongs_to :user
  has_many :diaries, through :diary_tags
end
