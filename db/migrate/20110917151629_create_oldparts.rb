class CreateOldparts < ActiveRecord::Migration
  def change
    create_table :oldparts do |t|
      t.string :name
      t.string :drawing
      t.integer :count
      t.string :factory
      t.string :pattern
      t.string :depot
      t.string :status
      t.string :occupy
      t.datetime :occupytime
      t.datetime :warehousing_at
      t.datetime :warehousing_on

      t.timestamps
    end
  end
end
