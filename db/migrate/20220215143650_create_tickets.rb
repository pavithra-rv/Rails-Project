class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :age
      t.integer :no_of_tickets

      t.timestamps
    end
  end
end
