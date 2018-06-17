require 'open-uri'
require 'mini_magick'

class Api::V1::PicturesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_picture, only: [:show, :destroy, :jpeg, :gif, :png, :tiff]

  def index
    @pictures = policy_scope(Picture)
  end

  def show
  end

  def create
    picture_params[:picture].each do |u|
      @picture = Picture.new(u)
      @picture.user = current_user
      file_path = @picture.source
      pic = MiniMagick::Image.open(file_path)
      @picture.format = pic.type
      @picture.width = pic.width
      @picture.height = pic.height
      authorize @picture
      create_active_storage(@picture, pic)
      # render :index
    end
  end

  def jpeg
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "jpeg"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    create_active_storage(@picture, pic)
  end

  def gif
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "gif"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    create_active_storage(@picture, pic)
  end

  def png
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "png"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    create_active_storage(@picture, pic)
  end

  def tiff
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "tiff"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    create_active_storage(@picture, pic)
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
    raise
    @picture = Picture.find(params([:id])
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

# def picture_params
#   params.require(:picture).map do |p|
#     ActionController::Parameters.new(p).permit(
#       :source
#     )
#   end
# end


# def picture_params
#   params.require(:pictures).each do |p|
#     p.permit(:source)
#   end
# end


# def picture_params
#   params.require(:picture).permit(:source)
# end


  # def create
  #   @picture = Picture.new(picture_params)
  #   @picture.user = current_user
  #   file_path = @picture.source
  #   pic = MiniMagick::Image.open(file_path)
  #   @picture.format = pic.type
  #   @picture.width = pic.width
  #   @picture.height = pic.height
  #   authorize @picture
  #   create_active_storage(@picture, pic)
  # end
