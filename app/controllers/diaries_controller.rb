class DiariesController < ApplicationController

  def index
    @diaries = Diary.where(user_id:current_user)

  end

  def show
  end

  def new
    @diary = Diary.new()
  end

  def create
    @diary = Diary.new(diary_params)
    
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
    params.require(:diary).permit(:content,:location,:diary_date,:picture)
    
  end

end
