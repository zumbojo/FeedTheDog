class NoncesController < ApplicationController
  def create
    render :text => "nonce motherfucker!"
  end

  def use
    render :text => "failure"
  end

end
