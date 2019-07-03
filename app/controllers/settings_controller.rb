class SettingsController < ApplicationController
  def index
    @user_tags = current_user.present? ? current_user.tags : []
    # @tags = current_user.tags.where('label LIKE ?')
  end
  
end