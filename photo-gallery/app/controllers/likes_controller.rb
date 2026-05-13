class LikesController < ApplicationController
  def create
    photo = Photo.find(params[:photo_id])
    Current.user.likes.find_or_create_by!(photo: photo)
    redirect_to photos_path
  end

  def destroy
    photo = Photo.find(params[:photo_id])
    Current.user.likes.find_by(photo: photo)&.destroy
    redirect_to photos_path
  end
end
