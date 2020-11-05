class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text       :description, null: false
      t.references :user,        foreign_key: true
      t.integer    :likes_count
      t.timestamps
    end
  end
end
