module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def subscription?
    if user_signed_in?
      current_user.subscription.present?
    end
  end
end
