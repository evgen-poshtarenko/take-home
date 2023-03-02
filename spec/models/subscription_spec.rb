require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:test_user) {
    User.create(name: "Name", email: "test@gmail.com", password: "abc11117611")
  }

  describe 'common validations' do
    it { is_expected.to validate_presence_of(:card_number) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:cvc_code) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe 'custom validations' do
    subject {
      described_class.new(user_id: test_user.id,
                          card_number: "1234 1234 1234 1234",
                          expiration_date: "08/26",
                          cvc_code: "111")
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid with size of card number less than 16" do
      subject.card_number = '1234 1234 1234'
      expect(subject).to_not be_valid
    end

    it "is not valid with symbols in card number" do
      subject.card_number = '1234 12a4 1234 123!'
      expect(subject).to_not be_valid
    end

    it "is not valid with error card number" do
      subject.card_number = '1234 1234 1234'
      expect(subject).to_not be_valid
    end

    it "is not valid with error expiration date" do
      subject.expiration_date = '08/16'
      expect(subject).to_not be_valid
    end

    it "is not valid when cvc is 999" do
      subject.cvc_code = '999'
      expect(subject).to_not be_valid
    end
  end
end
