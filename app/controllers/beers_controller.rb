class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit, :create]
  before_action :ensure_that_signed_in, except: [:index, :show]


  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.all
    order = params[:order] || 'name'

    @beers = case order
               when 'name' then @beers.sort_by{ |b| b.name }
               when 'brewery' then @beers.sort_by{ |b| b.brewery.name }
               when 'style' then @beers.sort_by{ |b| b.style.name }
             end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  def list

  end

  # GET /beers/new
  def new
    @beer = Beer.new
    @brewery = Brewery.all
  end

  # GET /beers/1/edit
  def edit
    @brewery = Brewery.all
  end


  def set_breweries_and_styles_for_template
    @styles = []
    Style.all.each do |s|
      @styles << (s.name)
    end
  end


  # POST /beers
  # POST /beers.json

  def create

    modifiedParams = beer_params;
    modifiedParams["style"] = Style.where(name: beer_params["style"]).first;
    @beer = Beer.new(modifiedParams)

    respond_to do |format|
      if @beer.save
        format.html {  redirect_to beers_url, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
        @beer = Beer.new
        @brewery = Brewery.all
        set_breweries_and_styles_for_template
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to beers_url, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    if (current_user.admin)

    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
    else
      respond_to do |format|
        format.html { redirect_to breweries_url, notice: 'You need to be admin to do that' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style, :brewery_id)
    end
end
