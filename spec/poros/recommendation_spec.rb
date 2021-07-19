require 'rails_helper'

RSpec.describe Recommendation do
  it 'exists' do
    attr = { id: 12,
             title: 'Captain Marvel'
              }

    rec = Recommendation.new(attr)
    expect(rec).to be_a(Recommendation)
    expect(rec.title).to eq('Captain Marvel')
  end
end
