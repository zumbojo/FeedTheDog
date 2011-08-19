class NoncesController < ApplicationController
  def create
    nonce = Nonce.create
    if nonce.save
      render :text => nonce.unsigned_nonce
    else
      render :text => "failure"
    end
  end

  def use
    nonce = Nonce.find_by_signed_nonce(params[:signed_nonce])

    if !nonce.nil? &&
      nonce.used_at.nil? &&
      nonce.created_at.advance(:minutes => 10) >= DateTime.now

      nonce.used_at = DateTime.now

      if nonce.save
        # todo: activate arduino

        render :text => "success"
      else
        break
      end
    else
      render :text => "failure"
    end
  end

end
