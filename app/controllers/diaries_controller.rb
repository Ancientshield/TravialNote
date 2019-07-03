class DiariesController < ApplicationController
  before_action :authenticate_user!
 
  def index
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)

    @diaries = current_user.diaries.where(is_published: true).order(:diary_date)

  end

  def show
    @diary = current_user.diaries.find_by(id: params[:id])
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
    @tag_items = @diary.tags

  end

  def new
    if current_user.diaries.where(is_published: false).any?
      @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
    else
      redirect_to new_draft_path
    end

    @diary = current_user.diaries.new(diary_date: Time.now)
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
    if params[:delete_session]
      session.delete(:location)
    end

    if session[:location].present?
      @diary.location = session[:location]
      # session.delete(:location)
    end
    
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
    @diary.location = session[:location]

    # binding.pry
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

  def edit
    @diary = current_user.diaries.find_by(id: params[:id])
    @drafts = current_user.diaries.where(is_published: false).order(:diary_date).limit(3)
    items = []
    @tag_items = @diary.tags

    @user_tags = current_user.tags - @tag_items
    render :new
    
  end
  
  def update
    @diary = current_user.diaries.find_by(id: params[:id])
    @diary.is_published= true if params[:is_published] == 'true'
    @diary.is_published= false if params[:is_published] == 'false'
    @tag_items = @diary.tags
    items = params[:label]
    
    @user_tags = current_user.tags - @tag_items
    
    diary_tags = @diary.diary_tags
    if @diary.update(diary_params)
      unless diary_tags.nil?
        diary_tags.each do |item|
          item.destroy
        end
      end
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

  def destroy
    @diary = current_user.diaries.find_by(id: params[:id])
    diary_tags = @diary.diary_tags
    unless diary_tags == []
      diary_tags.each do |item|
        item.destroy
      end
    end
    @diary.destroy if @diary
    redirect_to root_path
  end
  
  def set_map_session
    location_params = params.permit(location: {})
    session[:location] = location_params[:location]
  end

  private
  def diary_params
    # params.require(:diary).permit(:content,:location,:diary_date,:cover)
    params.require(:diary).permit(:content,:location,:diary_date,:picture)
  end


end
