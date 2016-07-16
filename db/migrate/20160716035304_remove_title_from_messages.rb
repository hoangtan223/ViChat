class RemoveTitleFromMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :title, :string
  end
end
