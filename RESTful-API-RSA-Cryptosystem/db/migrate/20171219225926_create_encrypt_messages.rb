class CreateEncryptMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :encrypt_messages do |t|
      t.text :content

      t.timestamps
    end
  end
end
