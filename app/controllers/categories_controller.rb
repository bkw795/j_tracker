class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new( params[:category] )
    if @category.save
      redirect_to @category
    else
      flash[:error] = "Something went wrong."
      render 'new'
    end
  end

  def show
    @category = Category.find( params[:id] )
  end

  def index
    @categories = Category.all
  end

end
