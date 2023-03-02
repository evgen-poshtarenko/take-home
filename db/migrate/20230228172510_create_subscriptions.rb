class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.string :card_number
      t.string :expiration_date
      t.string :cvc_code
      t.timestamps
    end
  end
end
