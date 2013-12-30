class SectionsController < ApplicationController
  # GET /sections.json
  def index
    @sections = Section.ordered
  end
end
