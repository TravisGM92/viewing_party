require 'rails_helper'

RSpec.describe Movie do
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
                release_date: '2020-10-01'
              }

      movie = Movie.new(attr)
      expect(movie).to be_a(Movie)
      expect(movie.title).to eq('The Dogs')
      expect(movie.overview).to eq('Great Movie')
  end
end
