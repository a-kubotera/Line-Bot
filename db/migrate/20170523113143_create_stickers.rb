class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.integer:packId
      t.integer:sticId
      t.string:imageUrl
      t.timestamps null: false
    end
  end
end
