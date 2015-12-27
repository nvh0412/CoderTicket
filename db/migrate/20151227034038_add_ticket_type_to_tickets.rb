class AddTicketTypeToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :ticket_type, index: true, foreign_key: true
  end
end
