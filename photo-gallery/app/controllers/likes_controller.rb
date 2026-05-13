class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    Current.user.likes.find_or_create_by!(photo: @photo)
    render partial: "photos/like", locals: { photo: @photo }
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    Current.user.likes.find_by(photo: @photo)&.destroy
    render partial: "photos/like", locals: { photo: @photo }
  end
end
