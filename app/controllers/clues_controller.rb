class CluesController < ApplicationController

=begin
  def new
  end

  def create
    site = "http://j-archive.com/showgame.php?game_id=3959"
    create_clues_from_site( site )
    redirect_to root_path
  end
=end

  def show
    @clue = Clue.find( params[:id] )
  end

  def index
    @clues = Clue.all
  end
end
