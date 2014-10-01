class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.belongs_to :publication
      t.text :content
      t.string :worker_id
      t.string :hit_id
      t.string :assignment_id

      t.timestamps
    end
  end
end
