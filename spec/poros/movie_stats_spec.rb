require 'rails_helper'

RSpec.describe 'MovieStats runtime calculation' do
  it 'exists' do
    attr = { popularity: 29,
             vote_count: 10,
             id: 2,
             original_language: 'eng',
             origingal_title: 'The Dogs',
             genre_ids: [1],
             title: 'The Dogs',
             vote_average: 8.2,
             overview: 'Great Movie',
             release_date: '2020-10-01',
             runtime: 148
              }
    movie = Movie.new(attr)
    expect(MovieStats.calculate_time(movie)).to eq("2 hours and 28 minutes")
  end
end
