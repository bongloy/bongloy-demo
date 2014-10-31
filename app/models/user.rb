class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :registerable,
         :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  def self.find_or_create_from_oauth(auth)
    oauth_email = auth.info.email

    user_from_oauth = where(auth.slice(:provider, :uid))
    user_from_email = where(:email => oauth_email)

    user = where.any_of(user_from_oauth, user_from_email).first_or_initialize do |u|
      u.email = oauth_email
      u.password = Devise.friendly_token[0,20]
      u.first_name = auth.info.first_name
      u.last_name = auth.info.last_name
    end

    user.provider = auth.provider
    user.uid = auth.uid
    user
  end

  def display_name
    first_name || email
  end
end
