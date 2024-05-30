class ProfilesController < ApplicationController

  # consider, if route is users/:id/profile, @profile, should be @profile = User.find(params[:id]), right? and then adjust profile views to dynamically show certain things when profile belongs to current_user
  def show
    @user = User.find(params[:user_id])
    @profile = User.find(params[:user_id]).profile
  end

  def edit
    # @current_user = current_user
    @profile = User.find(params[:user_id]).profile
    # @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(current_user), notice: 'Profile successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :bio, :age, :location)
  end
end
