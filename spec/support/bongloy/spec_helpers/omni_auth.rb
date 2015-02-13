module Bongloy
  module SpecHelpers
    class OmniAuth
      attr_accessor :email, :first_name, :last_name, :auth, :provider, :uid

      def initialize(options = {})
        self.provider = options[:provider] || :facebook
        self.email = options[:email] || "mara@example.com"
        self.first_name = options[:first_name] || "Mara"
        self.last_name = options[:last_name] || "Kheam"
        self.uid = options[:uid] || "1234"
        self.auth = add_mock(provider)
      end

      private

      def add_mock(provider)
        ::OmniAuth.config.add_mock(
          provider, {:uid => uid, :info => {:email => email, :first_name => first_name, :last_name => last_name}}
        )
      end
    end
  end
end
