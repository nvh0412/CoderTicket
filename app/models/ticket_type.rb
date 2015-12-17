class TicketType < ActiveRecord::Base
  belongs_to :event

  validates :name, inclusion: ["courtside", "vip", "premium", "standard"]
  validates :max_quantity, numericality: { less_than_or_equal_to: 10 }
end
