class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.string     :bike_name, null: false
      t.integer    :cc_id,    null: false
      t.integer    :maker_id, null: false
      t.integer    :type_id,  null: false
      t.references :user,     null: false, foreign_key: t
      t.timestamps
    end
  end
end
