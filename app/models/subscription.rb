# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates_presence_of :card_number, :expiration_date, :cvc_code

  validate :valid_card_number?, if: ->{ errors[:card_number].blank? }
  validate :valid_expiration_date?, if: ->{ errors[:expiration_date].blank? }
  validate :valid_cvc?, if: ->{ errors[:cvc_code].blank? }

  after_create :send_email

  def send_email
    SubscriptionMailer.with(user: user).subscription_info_email.deliver_now
  end

  def valid_card_number?
    card_num = card_number.delete(' ')
    errors.add(:card_number, 'size must be 16') if card_num.size != 16
    errors.add(:card_number, 'must be only integers') unless card_num !~ /\D/
  end

  def valid_cvc?
    errors.add(:cvc_code, "can't be 999") if cvc_code == '999'
  end

  def valid_expiration_date?
    month, year = expiration_date.split('/')
    if Date.new("20#{year}".to_i, month.to_i, 1) < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
end
