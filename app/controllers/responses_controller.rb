
class ResponsesController < ApplicationController

  def create
    @response = @current_user.respond!( params[:response][:clue_id], params[:response][:responded],
                                        params[:response][:result] )
    if @response.save
      game_id = Clue.find( params[:response][:clue_id] ).game.id
      redirect_to game_path( :id => game_id )
    else
      redirect_to clue_path( :id => params[:response][:clue_id], :error => "Something went wrong. Please try again." )
    end
  end

  def destroy

  end

end
