class DiariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @diaries = current_user.diaries.where(is_published: true)
  end

  def show
    @diary = current_user.diaries.find_by(id: params[:id])

    @tag_items = @diary.tags

  end

  def new
    @diary = current_user.diaries.new()
    items = []
    @tag_items = []
    @user_tags = current_user.tags
  end


  def create
    @diary = current_user.diaries.new(diary_params)
    @diary.is_published=true if params[:is_published] == 'true'
    @diary.is_published=false if params[:is_published] == 'false'
    items = params[:label]
    @tag_items = []
    @user_tags = current_user.tags
    # @picture = Picture.new(diary_params)
    if @diary.save 
      unless items == []
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
  
  def edit
    @diary = current_user.diaries.find_by(id: params[:id])
    @tag_items = @diary.tags
    @user_tags = current_user.tags - @tag_items
    items = []
    render :new
    
  end
  
  def update
    @diary = current_user.diaries.find_by(id: params[:id])
    @diary.is_published= true if params[:is_published] == 'true'
    @diary.is_published= false if params[:is_published] == 'false'
    items = params[:label]
    @tag_items = @diary.tags
    @user_tags = current_user.tags - @tag_items
    diary_tags = @diary.diary_tags.where(diary_id: @diary.id)
    diary_tags.each do |item|
      item.destroy
    end

    if @diary.update(diary_params)

      unless items == []
        items.each do |item|
          current_user.tags.find_or_create_by(label: item)
          tag_id = current_user.tags.find_by(label: item).id
          # binding.pry
          DiaryTag.create(diary_id: @diary.id, tag_id: tag_id)
        end
      end
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
