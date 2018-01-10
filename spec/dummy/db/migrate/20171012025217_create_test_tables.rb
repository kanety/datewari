class CreateTestTables < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :group
      t.string :name
      t.timestamps
    end

    create_table :groups do |t|
      t.string :name
      t.timestamps
    end
  end
end
