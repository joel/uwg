class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title, index: {unique: true}
      t.text :body
      t.integer :lock_version, default: 0, null: false

      t.timestamps
    end
  end
end
