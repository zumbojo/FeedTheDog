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

    # pseudo:
    # accept signed_nonce from browser
    # check db for signed_nonce, where used date is nil
    # if found, set used date and save row
    # if row saved, perform feeding routine
    # return success
    # all other conditions return failure
  end

end
