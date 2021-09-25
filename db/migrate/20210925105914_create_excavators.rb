class CreateExcavators < ActiveRecord::Migration[6.1]
  def change
    create_table :excavators do |t|
      t.string :company_name
      t.string :address
      t.boolean :crew_on_site
      t.integer :ticket_id

      t.timestamps
    end
    add_index :excavators, :ticket_id
  end
end
