class RelatioonshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    followed = current_user.followeds.new(user_id: user.id)
    followed.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    followed = current_user.followeds.find_by(user_id: user.id)
    followed.destroy
    redirect_to request.referer
  end
end
