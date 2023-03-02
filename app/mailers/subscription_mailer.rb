# frozen_string_literal: true

class SubscriptionMailer < ApplicationMailer
  def subscription_info_email
    @user = params[:user]
    @date = (@user.subscription.created_at + 1.month).strftime("%d.%m.%Y")
    mail(to: @user.email, subject: 'Subscription')
  end
end
