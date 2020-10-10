require 'rails_helper'

describe MovieParty, type: :model do
  describe 'validations' do
    it {should validate_presence_of :movie_title}
    it {should validate_presence_of :duration}
    it {should validate_presence_of :date}
    it {should validate_presence_of :start_time}
    it {should validate_presence_of :host}
  end
  #
  # describe 'relationships' do
  #   it {should have_many :friendships}
  #   it {should have_many(:friends).through(:friendships)}
  # end
end