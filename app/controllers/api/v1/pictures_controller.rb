class Api::V1::PicturesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_picture, only: [:show, :update]

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

  private

  def set_picture
    @picture = Picture.find(params[:id])
    authorize @picture
  end

  def picture_params
    params.require(:picture).permit(:format, :width, :height, :url, :updated_at)
  end

  def render_error
    render json: { errors: @picture.errors.full_messages },
      status: :unprocessable_entity
  end

end
