class DiariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @diaries = current_user.diaries.where(is_published: true)
  end

  def show
    @diary = current_user.diaries.find_by(id: params[:id])

    @tags = @diary.tags

  end

  def new
    @diary = current_user.diaries.new()

    @tag = Tag.new()
    @tag_items = current_user.tags
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    @diary.is_published=true if params[:is_published] == 'true'
    @diary.is_published=false if params[:is_published] == 'false'
    # @picture = Picture.new(diary_params)

    if @diary.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
    @diary = current_user.diaries.find_by(id: params[:id])
    render :new

  end

  def update
    @diary = current_user.diaries.find_by(id: params[:id])
    @diary.is_published= true if params[:is_published] == 'true'
    @diary.is_published= false if params[:is_published] == 'false'
    if @diary.update(diary_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @diary = current_user.diaries.find_by(id: params[:id])
    @diary.destroy if @diary
    redirect_to root_path
  end

  private
  def diary_params
    # params.require(:diary).permit(:content,:location,:diary_date,:cover)
    params.require(:diary).permit(:content,:location,:diary_date,:picture)
  end
  


end
