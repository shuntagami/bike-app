class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text       :description, null: false
      t.string     :image, null: false
      t.references :user,        foreign_key: true
      t.integer    :likes_count
      t.timestamps
      t.string     :weather, null: false
      t.string     :feeling, null: false
      t.string     :road_condition, null: false
    end
  end
end
