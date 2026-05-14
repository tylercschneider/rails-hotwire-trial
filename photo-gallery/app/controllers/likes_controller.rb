class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    Current.user.likes.find_or_create_by!(photo: @photo)
    render_like(liked: true)
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    Current.user.likes.find_by(photo: @photo)&.destroy
    render_like(liked: false)
  end

  private
    def render_like(liked:)
      @photo.reload
      render partial: "photos/like", locals: { photo: @photo, liked: liked }
    end
end
