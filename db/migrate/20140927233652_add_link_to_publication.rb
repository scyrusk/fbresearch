class AddLinkToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :link, :string
  end
end
