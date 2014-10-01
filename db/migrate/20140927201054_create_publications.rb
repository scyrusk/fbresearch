class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.string :venue
      t.text :summary
      t.integer :year

      t.timestamps
    end
  end
end
