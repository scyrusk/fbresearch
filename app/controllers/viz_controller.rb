class VizController < ApplicationController
  def index
    @publications = Publication.all.order('year ASC').group_by &:year
  end
end