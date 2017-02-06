class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :validatable, :omniauthable, :omniauth_providers => [:facebook]

  attr_accessor :password

  def self.find_or_create_from_oauth(auth)
    oauth_email = auth.info.email

    user = where(:provider => auth.provider).where(:uid => auth.uid).or(where(:email => oauth_email)).first_or_initialize

    user.email = oauth_email
    user.first_name = auth.info.first_name
    user.last_name = auth.info.last_name
    user.provider = auth.provider
    user.uid = auth.uid
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
