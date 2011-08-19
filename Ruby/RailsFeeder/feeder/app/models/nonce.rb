class Nonce < ActiveRecord::Base

  before_save :generate_values

  private

    def generate_values
      unsigned = ''
      32.times { unsigned << ('a'..'z').to_a[rand(26)] }
      self.unsigned_nonce = unsigned

      self.signed_nonce = Digest::SHA2.hexdigest(unsigned + PRIVATE_KEY)
    end

end
