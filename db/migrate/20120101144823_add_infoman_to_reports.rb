class AddInfomanToReports < ActiveRecord::Migration
  def change
    add_column :reports, :infoman, :string
  end
end
