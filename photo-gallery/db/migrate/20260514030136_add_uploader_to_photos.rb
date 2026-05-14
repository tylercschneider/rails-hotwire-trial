class AddUploaderToPhotos < ActiveRecord::Migration[8.1]
  def change
    add_reference :photos, :uploader, null: true, foreign_key: { to_table: :users }
  end
end
