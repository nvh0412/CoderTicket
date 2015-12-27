class TicketType < ActiveRecord::Base
  belongs_to :event
  validates :name, presence: true
  validates :max_quantity, numericality: { greater_than_or_equal_to: 0 }
end
