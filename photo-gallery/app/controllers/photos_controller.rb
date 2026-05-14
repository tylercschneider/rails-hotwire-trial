class PhotosController < ApplicationController
  def index
    @photos = Photo.order(:id)
    @liked_photo_ids = Current.user.likes.where(photo_id: @photos).pluck(:photo_id).to_set
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_path, notice: "Photo added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def photo_params
      params.require(:photo).permit(:photographer, :source_url, :src_medium, :alt)
    end
end
