class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def group_params; end
end
