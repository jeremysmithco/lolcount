class UsersController < ApplicationController
  
  def index
    @users = User.find(:all, :joins => :received_lols, :select => 'users.*, count(lols.lolee_id) as lol_count', :group => 'users.id', :limit => 100, :order => 'lol_count desc')
  end
  
  def show
    @user = User.find_by_screen_name(params[:screen_name])
  end
  
end