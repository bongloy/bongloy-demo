require 'rails_helper'

describe User do
  subject { build(factory) }
  let(:factory) { :user }
  let(:omniauth) { Bongloy::SpecHelpers::OmniAuth.new(omniauth_options) }
  let(:omniauth_options) { {} }

  describe "#display_name" do
    context "has a first name" do
      subject { build(factory, :first_name => "Mara") }
      it { expect(subject.display_name).to eq(subject.first_name) }
    end

    context "does not have a first name" do
      it { expect(subject.display_name).to eq(subject.email) }
    end
  end

  describe ".find_or_create_from_oauth(auth)" do
    let(:user) { described_class.find_or_create_from_oauth(omniauth.auth) }

    def setup_scenario
      user
    end

    before do
      setup_scenario
    end

    def assert_user!(options = {})
      if options[:persisted]
        expect(subject).to(be_persisted)
        subject.reload
      else
        expect(subject).not_to(be_persisted)
      end
      expect(subject.email).to eq(omniauth.email)
      expect(subject.first_name).to eq(omniauth.first_name)
      expect(subject.last_name).to eq(omniauth.last_name)
    end

    context "given Mara has never signed up before" do
      subject { user }

      context "with valid params" do
        it { assert_user!(:persisted => true) }
      end

      context "name is returned instead of first_name and last_name" do
        def setup_scenario
          omniauth.first_name = nil
          omniauth.last_name = nil
          omniauth.name = "Mara Chamroune"
          omniauth.add_mock!
          super
        end

        def assert_name!
          expect(subject.first_name).to eq("Mara")
          expect(subject.last_name).to eq("Chamroune")
        end

        it { assert_name! }
      end

      context "with invalid params" do
        let(:omniauth_options) { {:email => ""} }
        it { assert_user!(:persisted => false) }
      end
    end

    context "given Mara has already signed up" do
      subject { create(factory, :email => omniauth.email, :first_name => "Andy", :last_name => "Brand") }

      def setup_scenario
        subject
        super
      end

      it { assert_user!(:persisted => true) }
    end
  end
end
