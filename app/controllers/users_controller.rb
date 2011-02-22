class UsersController < ApplicationController
  
  def index
    @users = User.find(:all, :limit => 100, :order => 'received_lol_count desc')
  end
  
  def show
    @user = User.find_by_screen_name(params[:screen_name])
    @received_lols_count = @user.received_lols.count
    @received_lols = @user.received_lols.find(:all, :limit => 50, :order => 'created_at desc')
    @given_lols_count = @user.given_lols.count
    @given_lols = @user.given_lols.find(:all, :limit => 50, :order => 'created_at desc')
  end
  
end