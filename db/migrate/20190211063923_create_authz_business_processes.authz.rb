# This migration comes from authz (originally 20181129080058)
class CreateAuthzBusinessProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :authz_business_processes do |t|
      t.string :code
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
