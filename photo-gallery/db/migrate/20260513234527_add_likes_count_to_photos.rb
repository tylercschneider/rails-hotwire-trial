class AddLikesCountToPhotos < ActiveRecord::Migration[8.1]
  def change
    add_column :photos, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE photos
          SET likes_count = (SELECT COUNT(*) FROM likes WHERE likes.photo_id = photos.id)
        SQL
      end
    end
  end
end
