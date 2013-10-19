class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.string :movie_title
      t.string :status
      t.string :priority
      t.integer :movie_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
