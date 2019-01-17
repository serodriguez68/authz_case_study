class DriversController < ApplicationController
  around_action :verify_authorized
  # GET /drivers
  # GET /drivers.json
  def index
    authorize skip_scoping: true
    @drivers = apply_authz_scopes(on: Driver).includes(:user).all
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
    @driver = Driver.find(params[:id])
    authorize using: @driver
  end

  # GET /drivers/1/edit
  def edit
    @driver = Driver.find(params[:id])
    authorize using: @driver
  end

  # PATCH/PUT /drivers/1
  # PATCH/PUT /drivers/1.json
  def update
    @driver = Driver.find(params[:id])
    @driver.assign_attributes(driver_params)
    authorize using: @driver

    respond_to do |format|
      if @driver.save(driver_params)
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver }
      else
        format.html { render :edit }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def driver_params
      params.require(:driver).permit(:name)
    end
end
