class SearchesController < ApplicationController
  before_action :authenticate_user!

  def new
    # search_params
    @tags = current_user.tags
  end
  
  def show
    @tags = current_user.tags
    @diaries = []
    diary_ids = DiaryTag.where(tag_id: params[:format])
    
    diary_ids.each do |diary|
      @diaries << current_user.diaries.find_by(id: diary.diary_id)
    end
    
    if params[:search]
      @diaries = current_user.diaries.where('content LIKE ?', "%#{params[:search]}%")
    end
  end


  def create
    search_params
    render :new
  end
  private

  def search_params
    # 一定是有登入
    # 有搜尋文字
    if params[:search]
      # 執行搜尋，找tag或內容有 關鍵字
      # @tags = current_user.tags.where('label LIKE ?', "%#{params[:search]}%")
      @diaries = current_user.diaries.where('content LIKE ?', "%#{params[:search]}%")
    else
      # 
      @diaries = current_user.present? ? current_user.diaries : []
      # @tags = current_user.present? ? current_user.tags : []
    end
  end


end


# @tags = Tag.where('label LIKE ?', "%#{params[:search]}%").ids
# where('diaries.tag_id IN ? OR diaries.content LIKE ?',tag.ids, "%#{params[:search]}%")