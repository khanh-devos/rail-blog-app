class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :user_id
      t.text :text

      t.timestamps
    end
  end
end
