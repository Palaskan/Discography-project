class LpsController < ApplicationController
  before_action :set_lp, only: %i[ show edit update destroy ]
  before_action :load_artists, only: %i[ new edit]

  # GET /lps or /lps.json
  def index
    if params[:artist_id]
      @artist = Artist.includes(:lps).find(params[:artist_id])
      @lps = @artist.lps
    elsif params[:artist_name]
      @lps = Lp.joins(:artist).where("artists.name LIKE ?", "%#{params[:artist_name]}%")
    else
      @lps = Lp.all
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
    
  end

  # GET /lps/1 or /lps/1.json
  def show
    respond_to do |format|
      format.html { render layout: "application" }
      format.turbo_stream
    end
  end

  # GET /lps/new
  def new
    @lp = Lp.new
  end

  # GET /lps/1/edit
  def edit
    respond_to do |format|
      format.html { render layout: "application" }
      format.turbo_stream
    end
  end

  # POST /lps or /lps.json
  def create
    @lp = Lp.new(lp_params)

    respond_to do |format|
      if @lp.save
        format.html { redirect_to lps_url, notice: "Lp was successfully created." }
        format.json { render :show, status: :created, location: @lp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lps/1 or /lps/1.json
  def update
    respond_to do |format|
      if @lp.update(lp_params)
        format.html { redirect_to lp_url(@lp), notice: "Lp was successfully updated." }
        format.json { render :show, status: :ok, location: @lp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lps/1 or /lps/1.json
  def destroy
    @lp.destroy!

    respond_to do |format|
      format.html { redirect_to lps_url, notice: "Lp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lp
      @lp = Lp.find(params[:id])
    end

    def load_artists
      @artists = Artist.all
    end

    # Only allow a list of trusted parameters through.
    def lp_params
      params.require(:lp).permit(:name, :description, :artist_id)
    end
end
