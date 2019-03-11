class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.string :itinerary
      t.date :date_leave
      t.date :date_return
      t.string :travel_purpose
      t.text  :notes
     t.integer :user_id
    end
  end
end
