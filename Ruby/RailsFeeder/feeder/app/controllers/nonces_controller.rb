class NoncesController < ApplicationController
  def new
    render :text => "nonce motherfucker!"
  end

  def use
    render :text => "failure"
  end

end
