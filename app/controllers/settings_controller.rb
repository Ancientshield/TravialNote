class SettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_tags = current_user.present? ? current_user.tags : []
    # @tags = current_user.tags.where('label LIKE ?')
  end

  def new
    
  end

  def edit
    @setting = current_user.tags.find(params[:id])
  end

  def update
    @setting = current_user.tags.find(params[:id])
    if @setting.update!(setting_params)
      redirect_to settings_path, notice: "修改口袋成功！"
    else
      render :edit
    end
  end

  def destroy
    @setting = current_user.tags.find(params[:id])
    if @setting.destroy
      redirect_to settings_path, notice: "刪除成功！"
    end
  end

  private

  def setting_params
    params.require(:tag).permit(:id, :label)
  end
  
end