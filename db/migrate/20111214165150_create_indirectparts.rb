class CreateIndirectparts < ActiveRecord::Migration
  def change
    create_table :indirectparts do |t|
      t.string   :ind_name
      t.string   :ind_drawing
      t.integer  :ind_count
      t.string   :ind_factory
      t.string   :ind_pattern
      t.string   :ind_depot
      t.string   :ind_status
      t.string   :ind_occupy
      t.datetime :ind_occupytime
      t.datetime :ind_warehousing_at
      t.datetime :ind_warehousing_on
      t.string   :ind_running_number
      t.string   :ind_category
      t.string   :ind_factory_code
      t.string   :ind_fault_desc
      t.timestamps
    end
  end
end
