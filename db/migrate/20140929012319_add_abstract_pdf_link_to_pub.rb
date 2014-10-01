class AddAbstractPdfLinkToPub < ActiveRecord::Migration
  def change
    add_column :publications, :abstract, :text
    add_column :publications, :pdf_link, :string
  end
end
