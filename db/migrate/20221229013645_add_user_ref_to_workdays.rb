class AddUserRefToWorkdays < ActiveRecord::Migration[6.1]
  def change
    add_reference :workdays, :user, null: false, foreign_key: true
  end
end
