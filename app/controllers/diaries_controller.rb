class DiariesController < ApplicationController

  def index
    @diaries = current_user.diaries

  end

  def show
  end

  def new
    @diary = current_user.diaries.new()
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    # @diary.is_published=true if params[:commit] == 'publish'
    # @diary.is_published=false if params[:commit] == 'unpublish'
    # binding.pry

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
    params.require(:diary).permit(:content,:location,:diary_date)

  end

end
