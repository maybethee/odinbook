class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @profile = @user.profile
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(current_user), notice: 'Profile successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followed_id: @user.id)
  end

  def unfollow
    current_user.active_relationships.where(followed_id: @user.id).destroy_all
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :age, :location)
  end
end
