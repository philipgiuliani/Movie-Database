class CreateQualities < ActiveRecord::Migration
  def change
    create_table :qualities do |t|
      t.string :name
      t.integer :resolution_x
      t.integer :resolution_y

      t.timestamps
    end
  end
end
