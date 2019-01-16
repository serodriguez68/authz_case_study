class CitiesController < ApplicationController

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
    @city = City.find(params[:id])
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to cities_path, notice: 'City was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    @city = City.find(params[:id])

    if @city.update(city_params)
      redirect_to cities_path, notice: 'City was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city = City.find(params[:id])
    @city.destroy

    redirect_to cities_url, notice: 'City was successfully destroyed.'
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name)
    end
end
