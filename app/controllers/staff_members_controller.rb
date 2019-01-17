class StaffMembersController < ApplicationController
  around_action :verify_authorized

  def index
    authorize skip_scoping: true
    @staff_members = StaffMember.all
  end

  def new
    @user = User.new
  end

  def edit
    @staff_member = StaffMember.find(params[:id])
  end

  def create
    User.transaction do
      @user = User.new(user_params)

      if @user.save
        @staff_member = StaffMember.new(staff_member_params)
        @staff_member.user = @user
        @staff_member.save!
        redirect_to staff_members_path, notice: 'Staff member was successfully created. Give member password and ask for change'
      else
        render :new
      end
    end
  end

  def update
    @staff_member = StaffMember.find(params[:id])
    if @staff_member.update(staff_member_params)
      redirect_to staff_members_path, notice: 'Staff member was successfully updated.'
    else
      render :edit
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_member_params
      params.require(:staff_member).permit(:name)
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
