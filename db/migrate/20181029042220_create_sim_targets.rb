class CreateSimTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :sim_targets do |t|
      t.integer :year
      t.mediumtext :target

      t.timestamps
    end
  end
end
