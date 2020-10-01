class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.string     :name,        null: false
      t.text       :description, null: false
      t.string     :image,       null: false
      t.integer    :cc_id,       null: false
      t.integer    :maker_id,    null: false
      t.integer    :type_id,     null: false
      # t.references :user,        foreign_key: true
      t.timestamps
    end
  end
end
