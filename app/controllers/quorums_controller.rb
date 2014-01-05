class QuorumsController < ApplicationController
  # GET /quorums.json
  def index
    @quorums = Quorum.all
  end

  # PUT /quorums/1.json
  def update
    quorum = Quorum.find params[:id]

    if quorum.update_attributes quorum_params
      render json: { status: :success, quorum: quorum }
    else
      render json: { status: :error, errors: quorum.errors }, status: :unprocessable_entity
    end
  end

  private
  def quorum_params
    params.require(:quorum).permit [:quorum]
  end
end
