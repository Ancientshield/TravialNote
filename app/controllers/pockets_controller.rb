class PocketsController < ApplicationController
  before_action :authenticate_user!
  require 'date'
  def index
    #@pocket_lists = PocketList.find_by(id: current_user.id)
    # desc 降冪 descending
    # asc 升冪 ascending
    @pockets = current_user.pocket_lists.order(created_at: :asc)
    #@pocket = PocketList.where(user_id: params[:id])
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
  end

  def new
    @pocket = current_user.pocket_lists.new
    @pocket.location = session[:location]
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
  end

  def create
    @pocket = current_user.pocket_lists.new(location: session[:location])
    #@pocket.location = session[:location]
    if params[:pocket_list][:expect_date].blank?
      @pocket.expect_date = DateTime.now
    else
      @pocket.expect_date = params[:pocket_list][:expect_date]
    end
    @pocket.description = params[:pocket_list][:description]
    if @pocket.save
      redirect_to pockets_path, notice: "加入口袋成功！"
    else
      render :new
    end
  end
  
  def edit
    # 我要找目前pocket id & 是我的
    # 顯示編輯頁
    @pocket = PocketList.find_by(id: params[:id], user_id: current_user.id)
    # @pocket = current_user.pocket_lists.find(params[:id])
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
  end

  def update
    @pocket = current_user.pocket_lists.find(params[:id])
    if @pocket.update!(pocket_params)
      redirect_to pockets_path, notice: "修改口袋成功！"
    else
      render :edit
    end
  end

  def show
    @pockets = PocketList.find_by(user_id: params[:id])
    #@pocket = current_user.pocket_lists.find_by(id: params[:id])
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
  end

  def destroy
    @pocket = current_user.pocket_lists.find(params[:id])
    if @pocket.destroy
      redirect_to pockets_path, notice: "刪除成功！"
    end
  end

  def set_map_session
    location_params = params.permit(location: {})
    session[:location] = location_params[:location]
  end

  def pocket_params
    params.require(:pocket_list).permit(:expect_date, :description)
  end
end