class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :status

      t.timestamps
    end
  end
end
