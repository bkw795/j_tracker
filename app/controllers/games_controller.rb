class GamesController < ApplicationController
  include CluesHelper

  J_ARCHIVE_ROOT_PATH = "http://j-archive.com/showgame.php?game_id="

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @categories = @game.categories.split( "%%" )
    @stats = current_user.get_stats( @game.clues )
  end

  def new
  end

  def create
    site = "#{J_ARCHIVE_ROOT_PATH}#{params[:show_id]}"
    create_clues_from_site( site )
    redirect_to games_path
  end

end
