class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  devise :confirmable, :trackable
  # devise :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :friendships, dependent: :delete_all
  has_many :friends, :through => :friendships, dependent: :delete_all

  has_many :questions, dependent: :delete_all
  has_many :answers, dependent: :delete_all

  has_one_attached :profile_picture, dependent: :delete_all
  
  has_person_name

  acts_as_votable
  acts_as_follower
  acts_as_followable

  validates :name, presence: true
  
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
