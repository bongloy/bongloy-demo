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

  describe "omniauth methods" do
    describe ".find_or_create_from_oauth(auth)" do
      def do_find_or_create_from_oauth
        described_class.find_or_create_from_oauth(omniauth.auth)
      end

      context "given Mara has never signed up before" do
        def assert_user!(options = {})
          options[:persisted] ? expect(subject).to(be_persisted) : expect(subject).not_to(be_persisted)
          expect(subject.email).to eq(omniauth.email)
          expect(subject.first_name).to eq(omniauth.first_name)
          expect(subject.last_name).to eq(omniauth.last_name)
        end

        subject { do_find_or_create_from_oauth }

        context "with valid params" do
          it "should create an account for her" do
            assert_user!(:persisted => true)
          end
        end

        context "with invalid params" do
          let(:omniauth_options) { {:email => ""} }

          it "should return the invalid user" do
            assert_user!(:persisted => false)
          end
        end
      end

      context "given Mara has already signed up" do
        before do
          subject
          do_find_or_create_from_oauth
          subject.reload
        end

        subject { create(factory, :email => omniauth.email, :first_name => "Andy", :last_name => "Brand") }

        it "should set the omniauth id and provider" do
          expect(subject.email).to eq(omniauth.email)
          expect(subject.first_name).to eq("Andy")
          expect(subject.last_name).to eq("Brand")
          expect(subject.uid).to eq(omniauth.uid)
          expect(subject.provider).to eq(omniauth.provider.to_s)
        end
      end
    end

    describe ".new_with_session(params, session)" do
      let(:params) { {} }
      let(:session) { omniauth.auth }

      subject { described_class.new_with_session(params, session) }

      context "passing an empty session" do
        let(:session) { {} }
        it { expect(subject.email).to be_blank }
      end

      context "passing a session with devise raw facebook data" do
        let(:session) { {"devise.facebook_data" => {"extra" => {"raw_info" => {"email" => "someone@example.com"}}}}}
        it { expect(subject.email).to be_present }
      end
    end
  end
end
