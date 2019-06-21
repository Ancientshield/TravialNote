class Tag < ApplicationRecord
  belongs_to :user
  has_many :diary_tags
  has_many :diaries, through: :diary_tags

  attr_accessor :tag_items, :display_tags, :user_tags
  def initialize(attributes = {})
    super(attributes)
    # @user_tags = ['abc','xyz','ccc','123']
    # @display_tags = ['abc','xyz','ccc','123']
    # @user_tags = Tag.where(id: current_user)
    # @display_tags = Tag.where(id: current_user)
    @user_tags = []
    @display_tags = []
    @tag_items = []
  end

  def add_item(item)
    @display_tags.reject!{ |i| i == item }
    @tag_items << item unless item_filter(item)
  end

  def remove_item(item)
    @tag_items.reject!{ |i| i == item }
    @display_tags << item if in_user_tags?(item)
  end

  def tag_filter
    @tag_items - @user_tags
  end

  private
  def item_filter(item)
    @tag_items.include?(item)
  end

  def in_user_tags?(item)
    @user_tags.include?(item)
  end
end