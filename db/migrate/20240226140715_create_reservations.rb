class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :book, null:false, foreign_key: true
      t.references :user, null:false, foreign_key: true
      t.date :returned_on

      t.timestamps
    end
  end
end
