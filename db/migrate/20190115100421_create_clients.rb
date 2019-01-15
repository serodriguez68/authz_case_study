class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.references :user, foreign_key: true, uniqueness: true

      t.timestamps
    end
  end
end
