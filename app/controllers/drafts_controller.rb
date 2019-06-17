class DraftsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.diaries.where(is_published: false).any?
      @diaries = current_user.diaries.where(is_published: false)
    else
      redirect_to root_path
    end
  end

  def show
  end
end
