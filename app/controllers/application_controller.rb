class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #block ip address methods
  # before_filter :block_ip_addresses

  # protected

  # def block_ip_addresses
  #   head :unauthorized if current_ip_address == "XX.XX.XX.XX"
  # end

  # def current_ip_address
  #   request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
  # end
end
