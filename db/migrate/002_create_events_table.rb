class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :events do |t|
      t.references :application, null: false
      t.hstore :data
      t.timestamps
    end
  end
end
