class Bongloy::SpecHelpers::OmniAuth
  attr_accessor :email, :first_name, :last_name, :auth, :provider, :uid, :name

  def initialize(options = {})
    self.provider = options[:provider] || :facebook
    self.email = options[:email] || "mara@example.com"
    self.first_name = options[:first_name] || "Mara"
    self.last_name = options[:last_name] || "Kheam"
    self.name = options[:name] || "#{first_name} #{last_name}"
    self.uid = options[:uid] || "1234"
    add_mock!
  end

  def add_mock!
    self.auth = ::OmniAuth.config.mock_auth[provider] = ::OmniAuth::AuthHash.new(
      "provider" => provider,
      "uid" => uid,
      "info" => {
        "email" => email,
        "first_name" => first_name,
        "last_name" => last_name,
        "name" => name
      }
    )
  end
end
