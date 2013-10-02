class AddAttachmentCoverToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :movies, :cover
  end
end
