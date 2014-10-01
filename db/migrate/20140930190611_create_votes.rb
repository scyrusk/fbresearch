class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :worker_id
      t.string :hit_id
      t.string :assignment_id
      t.belongs_to :summary

      t.timestamps
    end
  end
end