require 'open-uri'
require 'mini_magick'

class Api::V1::PicturesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_picture, only: [:show, :destroy, :jpeg, :gif, :png, :tiff, :download]

  def index
    @pictures = policy_scope(Picture).order("id DESC")
  end

  def show
  end

  def create
    picture_params[:picture].each do |u|
      @picture = Picture.new(u)
      @picture.user = current_user
      file_path = @picture.source
      @pic = MiniMagick::Image.open(file_path)
      set_picture_details
      authorize @picture
      create_active_storage(@picture, @pic)
    end
    redirect_to api_v1_pictures_path
  end

  def duplicate
    @picture = @picture.dup
    file_path = @picture.source
    @pic = MiniMagick::Image.open(file_path)
  end

  def set_picture_details
    @picture.format = @pic.type
    @picture.width = @pic.width
    @picture.height = @pic.height
  end

  def jpeg
    duplicate
    @pic.format "jpeg"
    set_picture_details
    authorize @picture
    create_active_storage(@picture, @pic)
    render :show, status: :created
  end

  def gif
    duplicate
    @pic.format "gif"
    set_picture_details
    authorize @picture
    create_active_storage(@picture, @pic)
    render :show, status: :created
  end

  def png
    duplicate
    @pic.format "png"
    set_picture_details
    authorize @picture
    create_active_storage(@picture, @pic)
    render :show, status: :created
  end

  def tiff
    duplicate
    @pic.format "tiff"
    set_picture_details
    authorize @picture
    create_active_storage(@picture, @pic)
    render :show, status: :created
  end

  def create_active_storage(picture, pic)
    if picture.save
      picture.image.attach(io: File.open(pic.path), filename: "u#{@picture.user_id}_p#{@picture.id}.#{@picture.format}")
      picture.image_url = url_for(@picture.image)
      picture.save
    else
      render_error
    end
  end

  def destroy
    @picture.destroy
    head :no_content
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
    authorize @picture
  end

  def picture_params
    params.permit(picture: [:source])
  end

  def render_error
    render json: { errors: @picture.errors.full_messages },
      status: :unprocessable_entity
  end
end
