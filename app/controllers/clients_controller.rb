class ClientsController < ApplicationController
  around_action :verify_authorized
  # GET /clients
  # GET /clients.json
  def index
    authorize skip_scoping: true
    @clients = apply_authz_scopes(on: Client).includes(:user).all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])
    authorize using: @client
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    authorize using: @client
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    @client.assign_attributes(client_params)
    authorize using: @client

    respond_to do |format|
      if @client.save(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name)
    end
end
