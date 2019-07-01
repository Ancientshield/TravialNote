class SearchesController < ApplicationController


  def index
    search_params
  end

  private

  def search_params
    # 一定是有登入
    # 有搜尋文字
    if params[:search]
      # 執行搜尋，找tag或內容有 關鍵字
      @tags = current_user.tags.where('label LIKE ?', "%#{params[:search]}%")
      @diaries = current_user.diaries.where('content LIKE ?', "%#{params[:search]}%")
    else
      # 
      @diaries = current_user.present? ? current_user.diaries : []
      @tags = current_user.present? ? current_user.tags : []
    end
  end


end


# @tags = Tag.where('label LIKE ?', "%#{params[:search]}%").ids
# where('diaries.tag_id IN ? OR diaries.content LIKE ?',tag.ids, "%#{params[:search]}%")