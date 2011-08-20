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
        activate_arduino
        render :text => "success"
      else
        break
      end
    else
      render :text => "failure"
    end
  end

  private
    
    def activate_arduino
      # port_str = "/dev/tty.usbserial-A900cesN"  # MacBook
      port_str = "/dev/ttyUSB0"  # kitchen ubuntu box
      baud_rate = 9600
      data_bits = 8
      stop_bits = 1
      parity = SerialPort::NONE

      sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

      sp.putc(1);

      sp.close
    end

end
