# frozen_string_literal: true

class SubscriptionsController < ApplicationController

  def new
    @subscription = Subscription.new
    render locals: { active: true, user: current_user.present? }
  end

  def create
    @subscription = current_user.build_subscription(subscription_params)
    if @subscription.save
      render :new, locals: { active: false, user: true }
    else
      render :new, status: :unprocessable_entity, locals: { active: true, user: true }
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:card_number, :expiration_date, :cvc_code)
  end
end
