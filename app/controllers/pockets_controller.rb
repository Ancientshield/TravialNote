class PocketsController < ApplicationController
  before_action :authenticate_user!
  def index
    #@pocket_lists = PocketList.find_by(id: current_user.id)
    @pocket = current_user.pocket_lists
    #@pocket = PocketList.where(user_id: params[:id])
  end

  def new
    @pocket = current_user.pocket_lists.new
    @pocket.location = session[:location]

  end

  def create
    @pocket = current_user.pocket_lists.new
    @pocket.location = session[:location]
    @pocket.expect_date = params[:pocket_list][:expect_date]
    @pocket.description = params[:pocket_list][:description]
    if @pocket.save
      redirect_to pockets_path, notice: "加入口袋成功！"
    else
      render :new
    end
  end
  
  def edit
    @pocket = PocketList.find_by(user_id: params[:id])
  end

  def update
    @pocket = PocketList.find_by(user_id: params[:id])
    if @pocket.update
      redirect_to pockets_path, notice: "修改口袋成功！"
    end
  end

  def show
    @pocket = PocketList.find_by(user_id: params[:id])
    #@pocket = current_user.pocket_lists.find_by(id: params[:id])
  end

  def destroy
    @pocket = current_user.pocket_lists
    if @pocket.destroy
      redirect_to pockets_path, notice: "刪除成功！"
    end
  end

  def set_map_session
    location_params = params.permit(location: {})
    session[:location] = location_params[:location]
  end
end