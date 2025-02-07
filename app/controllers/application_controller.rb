class ApplicationController < ActionController::Base
  before_action :set_currents

  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_currents
    @current_user = Current.user if authenticated?
    @current_wave = Wave.current
  end
end
