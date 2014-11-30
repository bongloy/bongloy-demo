class HomesController < ApplicationController
  before_action :require_signed_out

  def show
  end

  private

  def require_signed_out
    redirect_to(user_root_path) if user_signed_in?
  end
end
