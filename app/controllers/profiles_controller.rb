class ProfilesController < ApplicationController
  include ProfilesHelper
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
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id_for_follower(@user),
                               partial: '/profiles/follow_button',
                               locals: { user: @user }),
          turbo_stream.update("#{@user.id}-follower-count",
                              partial: '/profiles/follower_count',
                              locals: { user: @user })
        ]
      end
    end
  end

  def unfollow
    current_user.active_relationships.where(followed_id: @user.id).destroy_all
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id_for_follower(@user),
                               partial: '/profiles/follow_button',
                               locals: { user: @user }),
          turbo_stream.update("#{@user.id}-follower-count",
                              partial: '/profiles/follower_count',
                              locals: { user: @user })
        ]
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :age, :location)
  end
end
