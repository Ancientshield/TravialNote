class PocketsController < ApplicationController
  before_action :authenticate_user!
  def index
    # @pocket_lists = PocketList.find_by(id: current_user.id)
     @pocket_lists = PocketList.all
  end

  def new
    @pocket = current_user.pocket_lists.new
    @pocket.location = session[:location]
  end

  def create
    @pocket = current_user.pocket_lists.new
    @pocket.location = session[:location]
    @pocket.expect_date = params[:pocket_list][:expect_date]
    if @pocket.save
      redirect_to pockets_path, notice: "加入口袋成功！"
    else
      render :new
    end
  end

  def set_map_session
    location_params = params.permit(location: {})
    session[:location] = location_params[:location]
  end
end