class DiaryTag < ApplicationRecord
  has_many :diaries
  has_many :diary_tags
end
