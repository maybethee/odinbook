class User < ApplicationRecord
  before_create :create_profile
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # followeds are the users that user is following.
  has_many :active_relationships, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followeds, through: :active_relationships, source: :followed

  # followers are the users following the user.
  has_many :passive_relationships, foreign_key: :followed_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one :profile, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def create_profile
    build_profile()
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_now
  end
end
