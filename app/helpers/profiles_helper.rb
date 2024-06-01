module ProfilesHelper
  # include ActionView::RecordIdentifier

  def following?(user)
    current_user&.active_relationships&.exists?(followed_id: user.id)
  end
end
