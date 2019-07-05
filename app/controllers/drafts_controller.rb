class DraftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pockets = current_user.pocket_lists.order(created_at: :asc).limit(3)
    # binding.pry
    if current_user.diaries.where(is_published: false).any?
      @diaries = current_user.diaries.where(is_published: false).order(:diary_date)
    else
      redirect_to new_draft_path
    end
  end

  def new
    @pockets = current_user.pocket_lists.order(created_at: :asc).limit(3)
  end
end
