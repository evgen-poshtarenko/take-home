# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if resource.nil?
      redirect_back(fallback_location: request.referer, alert: "Invalid email or password." )
    else
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: request.referer
    end
  end
end
