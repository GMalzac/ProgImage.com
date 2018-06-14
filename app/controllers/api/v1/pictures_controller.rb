class Api::V1::PicturesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_picture, only: [:show, :update, :destroy]

  def index
    @pictures = policy_scope(Picture)
  end

  def show
  end

  def update
    if @picture.update(picture_params)
      render :show
    else
      render_error
    end
  end

  def create
    # begin
    @picture = Picture.new(picture_params)
    @picture.user = current_user
    file_path = @picture.url
    image = File.open file_path
    authorize @picture
    if @picture.save
      @picture.image.attach(io: File.open(file_path), filename: "u#{@picture.user_id}_p#{@picture.id}")
      @picture.image_url = url_for(@picture.image)
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
    params.require(:picture).permit(:format, :width, :height, :url, :updated_at, :image_url, :image)
  end

  def render_error
    render json: { errors: @picture.errors.full_messages },
      status: :unprocessable_entity
  end

end
