class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :cover_url, null: false
      t.integer :genre, default: 0

      t.timestamps
    end
  end
end
