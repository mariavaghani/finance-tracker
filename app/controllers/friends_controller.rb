class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(friend_id: friend.id, user_id: current_user.id).first
    friendship.destroy
    flash[:notice] = "#{friend.full_name} was successfully removed from your friend group"
    redirect_to my_friends_path
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friends/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'friends/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter info to search"
        format.js { render partial: 'friends/result' }
      end
    end
  end

  def create
    friend = User.find(params[:friend_id])
    Friendship.create(user_id: current_user.id, friend_id: friend.id)
    flash.now[:notice] = "Friend #{friend.full_name} was successfully added to your friend group"
    redirect_to my_friends_path

  end

end
