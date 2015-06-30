class AddCreatorToWorkflows < ActiveRecord::Migration
  def change
    add_column :workflows, :creator, :string
    add_column :workflows, :oldparter, :string
    add_column :workflows, :newparter, :string
    add_column :workflows, :info_worker, :string
  end
end
