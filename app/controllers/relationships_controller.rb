class RelationshipsController < ApplicationController
  def create
    @user = (params[:user_id])
    current_user.active_relationships.create(followed_id: @user)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @user = (params[:user_id])
    @relationship  = current_user.active_relationships.find_by(followed_id: @user)
    @relationship.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
