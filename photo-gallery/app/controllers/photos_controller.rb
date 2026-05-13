class PhotosController < ApplicationController
  def index
    @photos = Photo.order(:id)
    @liked_photo_ids = Current.user.likes.where(photo_id: @photos).pluck(:photo_id).to_set
  end
end
