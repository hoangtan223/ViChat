class RelationshipsController < ApplicationController
  def create
  	current_user.send_friend_request(params[:target_id])
  	redirect_to users_path
  end

  def accept_request
  	current_user.accept_friend_request(params[:target_id])
  	redirect_to users_path
  end
end
