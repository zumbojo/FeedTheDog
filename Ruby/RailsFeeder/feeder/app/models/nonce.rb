class Nonce < ActiveRecord::Base

  before_save :generate_values

  private

    def generate_values
      unsigned = ''
      32.times { unsigned << ('a'..'z').to_a[rand(26)] }
      self.unsigned_nonce = unsigned

      private_key = "pnwmrpjitekvmoyhrjkgbdcrghxkgqzc"
        # todo: roll a new key, put in non-versioned file
      self.signed_nonce = Digest::SHA2.hexdigest(unsigned + private_key)
    end

end
