class CreateJoinTableUsersItems < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :items, table_name: :items_users_read_status do |t|
      t.index [:user_id, :item_id]
      t.index [:item_id, :user_id]
    end
  end
end
