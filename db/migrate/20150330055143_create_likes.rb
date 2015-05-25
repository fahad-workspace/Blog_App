class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :article, index : true
      t.references :user, index : true

      t.timestamps null : false
    end
    add_foreign_key :likes, :articles
    add_foreign_key :likes, :users
  end
end
