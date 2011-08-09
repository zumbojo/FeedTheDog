class CreateNonces < ActiveRecord::Migration
  def self.up
    create_table :nonces do |t|
      t.string :unsigned_nonce
      t.string :signed_nonce
      t.datetime :used_at

      t.timestamps
    end
    add_index :nonces, :signed_nonce
  end

  def self.down
    drop_table :nonces
  end
end
