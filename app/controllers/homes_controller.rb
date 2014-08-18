class HomesController < ApplicationController
  defaults :singleton => true

  def show
    user_signed_in? ? redirect_to(new_charge_path) : super
  end

  private

  def resource
    nil
  end
end
