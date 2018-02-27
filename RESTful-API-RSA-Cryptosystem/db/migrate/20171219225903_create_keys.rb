class CreateKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :keys do |t|
      t.integer :n
      t.integer :e
      t.integer :d

      t.timestamps
    end
  end
end
