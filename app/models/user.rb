class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :validatable, :omniauthable, :omniauth_providers => [:facebook]

  attr_accessor :password

  def self.find_or_create_from_oauth(auth)
    logger.info("Finding or creating user from: #{auth}")

    oauth_provider = auth["provider"]
    oauth_uid = auth["uid"]
    oauth_info = auth["info"] || {}
    oauth_email = oauth_info["email"]

    user = where(:provider => oauth_provider).where(:uid => oauth_uid).or(where(:email => oauth_email)).first_or_initialize

    user.provider = oauth_provider
    user.uid = oauth_uid
    user.email = oauth_email
    user.first_name = oauth_info["first_name"]
    user.last_name = oauth_info["last_name"]
    user.save
    user
  end

  def display_name
    first_name || email
  end

  private

  def password_required?
    false
  end
end
