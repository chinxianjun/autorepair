class AddReferralToPartBuyings < ActiveRecord::Migration
  def change
    add_column :part_buyings, :referral, :string
    add_column :part_buyings, :salesman, :string
    add_column :part_buyings, :manager, :string
    add_column :part_buyings, :status, :string
  end
end
