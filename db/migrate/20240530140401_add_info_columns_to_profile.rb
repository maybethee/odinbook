class AddInfoColumnsToProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :name, :string, null: true
    add_column :profiles, :bio, :text, null: true
    add_column :profiles, :age, :integer, null: true
    add_column :profiles, :location, :string, null: true
  end
end
