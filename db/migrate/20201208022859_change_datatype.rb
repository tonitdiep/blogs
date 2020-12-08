class ChangeDatatype < ActiveRecord::Migration
  def change 
    change_column :blogs, :user_id, :integer
  end
end
