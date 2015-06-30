class CreateMetaEvents < ActiveRecord::Migration
  def change
    create_table :meta_events do |t|
      t.string :notes
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :repeat_until
      t.boolean :repeating_infinitely, default: false

      t.timestamps null: false
    end
  end
end
