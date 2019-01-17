class ServicesController < ApplicationController
  around_action :verify_authorized
  # GET /services
  # GET /services.json
  def index
    authorize skip_scoping: true
    @services = apply_authz_scopes(on: Service).includes(:client, :city, :driver).all
  end
  
  # GET /services/new
  def new
    authorize skip_scoping: true
    @service = Service.new
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    authorize using: @service

    if @service.save
      @service.assign_driver!
      redirect_to services_url, notice: 'Pinging Drivers'
    else
      render :new
    end
  end

  def client_cancel
    @service = Service.find params[:id]
    authorize using: @service

    if @service.cancel
      redirect_to services_url, notice: 'Service Cancelled'
    else
      redirect_to services_url, alert: 'The service is not cancellable'
    end
  end

  def driver_accept
    @service = Service.find params[:id]
    authorize using: @service

    if @service.accept
      redirect_to services_url, notice: 'Service Accepted. Please go and pick the client up'
    else
      redirect_to services_url, alert: 'Not possible to accept this service'
    end
  end

  def driver_reject
    @service = Service.find params[:id]
    authorize using: @service

    if @service.reject
      redirect_to services_url, notice: 'Service Rejected.'
    else
      redirect_to services_url, alert: 'Not possible to reject this service'
    end
  end

  def driver_finish
    @service = Service.find params[:id]
    authorize using: @service

    if @service.finish
      redirect_to services_url, notice: 'Service Completed'
    else
      redirect_to services_url, alert: 'Not possible to finish this service'
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:client_id, :city_id, :pickup_address, :drop_off_address, :accepted_on, :finished_on, :cancelled_on, :driver_id)
    end
end
