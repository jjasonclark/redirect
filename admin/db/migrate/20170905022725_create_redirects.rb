class CreateRedirects < ActiveRecord::Migration[5.1]
  def change
    create_table :redirects do |t|
      t.string :regex, null: false
      t.string :result, null: false
      t.integer :code, null: false
      t.integer :order, null: false

      t.timestamps
    end

    add_index :redirects, :order, unique: true
  end
end
