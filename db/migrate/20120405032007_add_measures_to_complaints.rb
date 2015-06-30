class AddMeasuresToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :measures, :text
    add_column :complaints, :manager, :string
  end
end
