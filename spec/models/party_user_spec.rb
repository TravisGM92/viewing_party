require 'rails_helper'

describe PartyUser, type: :model do

  describe 'relationships' do
    # attendees
    it {should belong_to :user}
    it {should belong_to :movie_party}
  end
end
