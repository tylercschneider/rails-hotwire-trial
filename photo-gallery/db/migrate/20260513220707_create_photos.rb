class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :photographer
      t.string :source_url
      t.string :src_medium
      t.string :alt

      t.timestamps
    end
  end
end
