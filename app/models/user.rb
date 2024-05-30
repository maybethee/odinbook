class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  
  
  has_many :followers, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followed, through: :followers, dependent: :destroy
  has_many :followed, foreign_key: :followed_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :followed, dependent: :destroy
  has_many :posts
  has_one :profile, dependent: :destroy

  before_create :create_profile

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
end
