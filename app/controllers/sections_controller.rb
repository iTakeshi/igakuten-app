class SectionsController < ApplicationController
  before_action :set_section, only: [:show]

  # GET /sections.json
  def index
    @sections = Section.ordered
  end

  # GET /sections/1.json
  def show
  end

  private
  def set_section
    @section = Section.find(params[:id])
  end
end
