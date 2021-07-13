class RemoveFistNameFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :fist_name
  end
end
