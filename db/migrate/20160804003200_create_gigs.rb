class CreateGigs < ActiveRecord::Migration[5.0]
  def change
    create_table :gigs do |t|
      t.string :time
      t.string :venue
      t.datetime :performance_date
      t.string :location

      t.timestamps
    end
  end
end
