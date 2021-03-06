class UsersController < ApplicationController

  def my_portfolio
    # debugger
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end

  def search
    if params[:search_param].blank?
      flash.now[:danger] = "Empty search query"
    else
      @users = User.search(params[:search_param])
      @users = current_user.except_current_users(@users)
      flash.now[:danger] = "No user found" if @users.blank?
    end
    render partial: 'friends/result'
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    
    if current_user.save
      flash[:success] = "Friend was succefully added"
    else
      flash[:danger] = "Something went wrong"
    end
    redirect_to my_friends_path
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end

end