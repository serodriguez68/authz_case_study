class CitiesController < ApplicationController
  around_action :verify_authorized
  # GET /cities
  # GET /cities.json
  def index
    authorize skip_scoping: true
    @cities = apply_authz_scopes(on: City).all
  end

  # GET /cities/new
  def new
    authorize skip_scoping: true
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
    @city = City.find(params[:id])
    authorize using: @city
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)
    authorize using: @city

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

    @city.assign_attributes(city_params)
    authorize using: @city

    if @city.save(city_params)
      redirect_to cities_path, notice: 'City was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city = City.find(params[:id])
    authorize using: @city
    @city.destroy

    redirect_to cities_url, notice: 'City was successfully destroyed.'
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name)
    end
end
