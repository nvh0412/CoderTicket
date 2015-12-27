class Event < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_event,
                  against: {
                    name: 'A',
                    extended_html_description: 'B'
                  },
                  using: :tsearch

  scope :up_comming, -> { where("ends_at >= ? and published = true", DateTime.current) }
  scope :find_recent_event, -> (event_id) {
    where("ends_at >= ? and id = ?", DateTime.current, event_id)
  }

  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types
  accepts_nested_attributes_for :ticket_types, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name, :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

end
