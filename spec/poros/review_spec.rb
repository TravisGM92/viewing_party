require 'rails_helper'

RSpec.describe Review do
  it 'exists' do
    attr = { author: 'Stubbinz McGee',
             content: 'This is the worst movie I have ever seen',
             id: 12,
             url: 'review_url'
              }

    review = Review.new(attr)
    expect(review).to be_a(Review)
    expect(review.author).to eq('Stubbinz McGee')
    expect(review.content).to eq('This is the worst movie I have ever seen')
  end
end
