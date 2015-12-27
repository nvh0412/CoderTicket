require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should validate_presence_of :venue }
  it { should validate_presence_of :extended_html_description }
  it { should validate_presence_of :category }
  it { should validate_presence_of :starts_at }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should belong_to :venue }
  it { should belong_to :category }
  it { should have_many :ticket_types }

end
