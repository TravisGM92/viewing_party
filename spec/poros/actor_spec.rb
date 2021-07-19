require 'rails_helper'

RSpec.describe Actor do
  it 'exists' do
    attr = { cast_id: 12,
                character: 'Spiderman',
                credit_id: 2,
                gender: 'Male',
                id: 24,
                name: "Tobey Maguire",
                profile_path: 'profile_path'
              }

      actor = Actor.new(attr)
      expect(actor).to be_a(Actor)
      expect(actor.character).to eq('Spiderman')
      expect(actor.name).to eq('Tobey Maguire')
  end
end
