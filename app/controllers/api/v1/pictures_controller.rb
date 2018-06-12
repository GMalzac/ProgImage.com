class Api::V1::PicturesController < Api::V1::BaseController
  def index
    @pictures = policy_scope(Picture)
  end
end
