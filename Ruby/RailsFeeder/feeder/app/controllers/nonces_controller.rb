class NoncesController < ApplicationController
  def create
    @nonce = Nonce.create
    if @nonce.save
      render :text => @nonce.unsigned_nonce
    else
      render :text => "failure"
    end
  end

  def use
    render :text => "failure"
  end

end
