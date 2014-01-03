class QuorumsController < ApplicationController
  # GET /quorums.json
  def index
    @quorums = Quorum.all
  end
end
