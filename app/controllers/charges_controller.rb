class ChargesController < ApplicationController
  def new
    @charge = Charge.new
  end
end
