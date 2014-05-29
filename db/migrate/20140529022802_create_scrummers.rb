class CreateScrummers < ActiveRecord::Migration
  def change
    create_table :scrummers do |t|
      t.string :name
      t.boolean :team

      t.timestamps
    end
  end
end
