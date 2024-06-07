module ProfilesHelper
  include ActionView::RecordIdentifier

  def following?(user)
    current_user&.active_relationships&.exists?(followed_id: user.id)
  end

  def profile_gravatar(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.profile.name, class: "profile-pic")
  end
  
  def dom_id_for_follower(follower)
    dom_id(follower)
  end
end
