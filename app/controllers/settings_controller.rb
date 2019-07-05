class SettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_tags = current_user.present? ? current_user.tags : []
    # @tags = current_user.tags.where('label LIKE ?')
  end

  def new
    items = []
    @tag_items = []
    @user_tags = current_user.tags
  end
  
  def create
    items = params[:label]
    @tag_items = []
    @user_tags = current_user.tags

    if @diary.save
      unless items.nil?
        items.each do |item|
          current_user.tags.find_or_create_by(label: item)
          tag_id = current_user.tags.find_by(label: item).id
          DiaryTag.create(diary_id: @diary.id, tag_id: tag_id)
        end
      end
      redirect_to root_path
    else
      render :new
    end
  end

  def create
    tag = params[:label]
    if current_user.tags.find_by(label: tag)
      redirect_to settings_path, notice:'這個標籤已經存在了喔' 
    elsif tag.include?(' ') 
      redirect_to settings_path, notice:''
    else  
      current_user.tags.find_or_create_by(label: tag)
      redirect_to settings_path, notice:'新增成功'
    end
  end

  def edit
    @setting = current_user.tags.find(params[:id])
  end

  def update
    @setting = current_user.tags.find(params[:id])
    check = current_user.tags.find_by(label: params[:tag][:label])
    if check.nil?
      if @setting.update!(setting_params)
        redirect_to settings_path, notice: "修改標籤成功！"
      else
        render :edit
      end
    else
      render :edit, notice: "已存在相同的標籤名稱"
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