class AddFbProfileToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :fb_profile, :string
  end
end
