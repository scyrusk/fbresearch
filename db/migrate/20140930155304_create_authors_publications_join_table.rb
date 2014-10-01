class CreateAuthorsPublicationsJoinTable < ActiveRecord::Migration
  def up
    create_table :author_publication_links do |t|
      t.belongs_to :author
      t.belongs_to :publication
      t.integer :order

      t.timestamps
    end

    drop_table :authors_publications
  end

  def down
    drop_table :author_publication_links

    create_table :authors_publications, id: false do |t|
      t.belongs_to :author
      t.belongs_to :publication
    end
  end
end