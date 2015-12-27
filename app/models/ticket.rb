class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_type

  validates_presence_of :user
  validates_numericality_of :quantity, less_than_or_equal_to: 10

  def save_ticket
    if valid?
      ticket_type.max_quantity = ticket_type.max_quantity - quantity
      if ticket_type.save
        save
        true
      else
        errors.add(:ticket, ticket_type.errors)
        false
      end
    end
  end
end
