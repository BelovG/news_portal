class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :title
      t.string  :description
      t.text    :content
      t.integer :user_id
      t.boolean :approval

      t.timestamps
    end
    add_index :posts, [:created_at, :approval, :user_id]
  end
end
