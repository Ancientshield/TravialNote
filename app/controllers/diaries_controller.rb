class DiariesController < ApplicationController

  def index
    # @diaries = Diary.where(user_id: current_user)
      @diaries = Diary.where(diary_date: 20190615)
  end

  def show
  end

  def new
    @diary = Diary.new()
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    
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
