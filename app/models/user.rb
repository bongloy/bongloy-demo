class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :validatable, :omniauthable, :omniauth_providers => [:facebook]

  attr_accessor :password

  class OAuthParser
    attr_accessor :auth,
                  :oauth_name, :oauth_first_name, :oauth_last_name,
                  :oauth_email, :oauth_provider, :oauth_uid,
                  :oauth_info, :oauth_extra_info

    def initialize(options = {})
      self.auth = options[:auth]
    end

    def parse
      self.oauth_provider = auth["provider"]
      self.oauth_uid = auth["uid"]
      self.oauth_info = auth["info"] || {}
      self.oauth_extra_info = (auth["extra"] || {})["raw_info"] || {}
      self.oauth_email = from_info("email")
      self.oauth_name = from_info("name")
      self.oauth_first_name = from_info("first_name") || parse_name.first
      self.oauth_last_name = from_info("last_name") || parse_name.last
    end

    def auth
      @auth || {}
    end

    private

    def from_info(key)
      oauth_info[key] || oauth_extra_info[key]
    end

    def parse_name
      oauth_name.to_s.split(/\s+/)
    end
  end

  def self.find_or_create_from_oauth(auth)
    logger.info("Finding or creating user from: #{auth}")
    oauth_parser = OAuthParser.new(:auth => auth)
    oauth_parser.parse

    oauth_provider = oauth_parser.oauth_provider
    oauth_uid = oauth_parser.oauth_uid
    oauth_email = oauth_parser.oauth_email

    user = where(:provider => oauth_provider).where(:uid => oauth_uid).or(where(:email => oauth_email)).first_or_initialize

    user.provider = oauth_provider
    user.uid = oauth_uid
    user.email = oauth_email
    user.first_name = oauth_parser.oauth_first_name
    user.last_name = oauth_parser.oauth_last_name
    user.save
    user
  end

  def display_name
    first_name || email
  end

  private

  def oauth_parser
    @oauth_parser || OAuthParser.new
  end

  def self.parse_oauth_parameters(auth)


    {
      "provider" => oauth_provider,
      "uid" => oauth_uid,
      "email" => oauth_email,
      "first_name" => oauth_first_name,
      "last_name" => oauth_last_name
    }
  end

  def password_required?
    false
  end
end
