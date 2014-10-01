class AuthorsPublications < ActiveRecord::Migration
  def change
    create_table :authors_publications, id: false do |t|
      t.belongs_to :author
      t.belongs_to :publication
    end
  end
end