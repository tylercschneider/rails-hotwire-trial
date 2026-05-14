class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ edit update destroy ]
  before_action :require_uploader, only: %i[ edit update destroy ]

  def index
    @photos = Photo.order(:id)
    @liked_photo_ids = Current.user.likes.where(photo_id: @photos).pluck(:photo_id).to_set
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.uploader = Current.user
    if @photo.save
      redirect_to photos_path, notice: "Photo added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to photos_path, notice: "Photo updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice: "Photo deleted."
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def require_uploader
      redirect_to photos_path, alert: "You can only manage your own photos." unless @photo.uploader == Current.user
    end

    def photo_params
      params.require(:photo).permit(:photographer, :source_url, :src_medium, :alt)
    end
end
