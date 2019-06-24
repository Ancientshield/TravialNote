class Tag < ApplicationRecord
  belongs_to :user
  has_many :diary_tags
  has_many :diaries, through: :diary_tags
  validates :label, presence: true, allow_blank: false
  attr_accessor :tag_items, :display_tags, :user_tags
  
  # def initialize(attributes = {},tag_items||=[],user_tags||=[])
  # def initialize(tag_items||=[],user_tags||=[])
  #   super(attributes)
  #   @tag_items = tag_items
  #   @user_tags = user_tags
  #   @display_tags = []
  # end

  # def add_item(item)
  #   @display_tags.reject!{ |i| i == item }
  #   @tag_items << item unless item_filter(item)
  # end

  # def remove_item(item)
  #   @tag_items.reject!{ |i| i == item }
  #   @display_tags << item if in_user_tags?(item)
  # end

  # def new_tag_filter
  #   @tag_items - @user_tags
  # end

  # def tag_filter
  #   @display_tags = @user_tags - @tag_items
  # end

  # private
  # def item_filter(item)
  #   @tag_items.include?(item)
  # end

  # def in_user_tags?(item)
  #   @user_tags.include?(item)
  # end
end