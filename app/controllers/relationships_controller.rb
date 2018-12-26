class RelationshipsController < ApplicationController
  def create
    current_user.active_relationships.create(followed_id: params[:user_id])
    redirect_to request.referrer || root_url
  end

  def destroy
    relationship  = current_user.active_relationships.find_by(followed_id: params[:user_id])
    relationship.destroy
    redirect_to request.referrer || root_url
  end
end
