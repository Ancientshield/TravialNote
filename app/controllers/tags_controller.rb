class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
   
  end

  def new
    @tag = Tag.new
  end

  def create

  end
  
  def edit

  end

  def update
  end

  def destroy
  end

  private
  def tag_params
  end

end
