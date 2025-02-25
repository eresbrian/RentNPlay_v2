class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]
  before_action :is_logged_in
  before_action :is_admin, only: [:destroy]
  before_action :is_game_owner, only: [:destroy, :update, :edit]


  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
    @requests = Request.where(game_id: params[:id])
  end

  
def is_game_owner
	if session[:account_id] != @game.owner_id
    if session[:is_admin] != 0
      redirect_to "/games", notice: "Action is forbidden" 
    end
	end
end


  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

    @game.owner_id = session[:account_id]

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:owner_id, :name, :description, :release_date, :genre, :maturity_rating, :platform, :rent_rate, :max_rent_duration, :status)
    end
end
