class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.references :client, foreign_key: true
      t.references :city, foreign_key: true
      t.string :pickup_address
      t.string :drop_off_address
      t.datetime :accepted_on
      t.datetime :finished_on
      t.datetime :cancelled_on
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
