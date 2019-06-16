class DiariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @diaries = current_user.diaries.where(is_published: true)
  end

  def show
  end

  def new
    @diary = current_user.diaries.new()
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    @diary.is_published=true if params[:commit] == 'publish'
    @diary.is_published=false if params[:commit] == 'unpublish'

    if @diary.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
  end

  def update
  end

  def destroy
  end

  private
  def diary_params
    params.require(:diary).permit(:content,:location,:diary_date,:cover)
  end
  
  def tag_params
    
  end

end
