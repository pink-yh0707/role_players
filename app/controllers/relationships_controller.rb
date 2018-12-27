class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.active_relationships.create(followed_id: params[:user_id])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @relationship  = current_user.active_relationships.find_by(followed_id: params[:user_id])
    @relationship.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
