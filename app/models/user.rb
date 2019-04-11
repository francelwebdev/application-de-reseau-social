class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  devise :confirmable, :trackable
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> {where(friendships: {accepted: true})}, through: :friendships, source: :friend
  has_many :received_friends, -> {where(friendships: {accepted: true})}, through: :received_friendships, source: :user
  has_many :pending_friends, -> {where(friendships: {accepted: false})}, through: :friendships, source: :friend
  has_many :requested_friendships, -> {where(friendships: {accepted: false})}, through: :received_friendships, source: :user

  acts_as_votable

  has_many :questions, dependent: :delete_all
  has_many :answers, dependent: :delete_all

  has_one_attached :profile_picture, dependent: :delete_all
  
  has_person_name

  acts_as_follower
  acts_as_followable

  validates :name, presence: true

  def friends
    active_friends | received_friends
  end

  def pending
    pending_friends | requested_friendships
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(name: data['name'],
    #        email: data['email'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    user
end

end
