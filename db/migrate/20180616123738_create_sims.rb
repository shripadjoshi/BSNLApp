class CreateSims < ActiveRecord::Migration[5.1]
  def change
    create_table :sims do |t|
      t.string :sim_no
      t.string :sim_type
      t.string :sim_pairedness
      t.string :sim_category
      t.boolean :sell_status

      t.timestamps
    end
  end
end
