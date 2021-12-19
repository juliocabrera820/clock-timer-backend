class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.integer :type
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
