require 'digest'

private_key = 'iffwtpbvdqhjcsuprzivpxynvhzlomks'
# roll another using 32.times { private_key << ('a'..'z').to_a[rand(26)] }

nonce = ''
32.times { nonce << ('a'..'z').to_a[rand(26)] }

puts "nonce: " + nonce
digest = Digest::SHA2.hexdigest(nonce + private_key)
puts "nonce + private_key SHA2: " + digest 
