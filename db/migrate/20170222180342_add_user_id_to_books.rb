class AddUserIdToBooks < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :user_id, foreign_key: true
  end
end
