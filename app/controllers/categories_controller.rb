class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def category_params; end
end
