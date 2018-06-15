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
    # begin
    @picture = Picture.new(picture_params)
    @picture.user = current_user
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    if @picture.save
      @picture.image.attach(io: File.open(pic.path), filename: "u#{@picture.user_id}_p#{@picture.id}.#{@picture.format}")
      @picture.image_url = url_for(@picture.image)
      @picture.save
      render :show, status: :created
    else
      render_error
    end
    # rescue => error
    # end
  end

  def jpeg
    # begin
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "jpeg"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    if @picture.save
      @picture.image.attach(io: File.open(pic.path), filename: "u#{@picture.user_id}_p#{@picture.id}.#{@picture.format}")
      @picture.image_url = url_for(@picture.image)
      @picture.save
      render :show, status: :created
    else
      render_error
    end
    # rescue => error
    # end
  end

  def gif
    # begin
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "gif"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    if @picture.save
      @picture.image.attach(io: File.open(pic.path), filename: "u#{@picture.user_id}_p#{@picture.id}.#{@picture.format}")
      @picture.image_url = url_for(@picture.image)
      @picture.save
      render :show, status: :created
    else
      render_error
    end
    # rescue => error
    # end
  end

  def png
    # begin
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "png"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    if @picture.save
      @picture.image.attach(io: File.open(pic.path), filename: "u#{@picture.user_id}_p#{@picture.id}.#{@picture.format}")
      @picture.image_url = url_for(@picture.image)
      @picture.save
      render :show, status: :created
    else
      render_error
    end
    # rescue => error
    # end
  end

  def tiff
    # begin
    @picture = @picture.dup
    file_path = @picture.source
    pic = MiniMagick::Image.open(file_path)
    pic.format "tiff"
    @picture.format = pic.type
    @picture.width = pic.width
    @picture.height = pic.height
    authorize @picture
    if @picture.save
      @picture.image.attach(io: File.open(pic.path), filename: "u#{@picture.user_id}_p#{@picture.id}.#{@picture.format}")
      @picture.image_url = url_for(@picture.image)
      @picture.save
      render :show, status: :created
    else
      render_error
    end
    # rescue => error
    # end
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
    params.require(:picture).permit(:format, :width, :height, :source, :image_url)
  end

  def render_error
    render json: { errors: @picture.errors.full_messages },
      status: :unprocessable_entity
  end

end

  # def update
  #   if @picture.update(picture_params)
  #     render :show
  #   else
  #     render_error
  #   end
  # end
