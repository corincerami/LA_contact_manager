class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contact do |table|
      table.string :first_name
      table.string :last_name
      table.string :phone_number
    end
  end
end
