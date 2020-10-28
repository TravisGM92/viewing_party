require 'rails_helper'

RSpec.describe 'movie discover page' do
  before(:each) do
    @user = User.create!(username: "eDog", email: "elah@email.com", password: "password")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'As an authenticated user' do
    describe "When I visit the movies page," do
      it "after clicking 'Discover Top 40 Movies', I should see the top 40 results," do
        json1 = File.read('spec/fixtures/top_40_movies_1.json')
        json2 = File.read('spec/fixtures/top_40_movies_2.json')

        stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json1)
        stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2").to_return(status: 200, body: json2)
        visit "/discover"
        click_button "Discover Top 40 Movies"
        # save_and_open_page
        within(first('.cards'))
          within('.card-front')
            within('.card-inner')
              expect(page).to have_link("Gabriel's Inferno")
        # expect(page).to have_content("40")
      end
        it "I should also see the 'Find Top Rated Movies' button and the Find Movies form at the top of the page." do
          json1 = File.read('spec/fixtures/top_40_movies_1.json')
          json2 = File.read('spec/fixtures/top_40_movies_2.json')
          stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json1)
          stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2").to_return(status: 200, body: json2)
          visit '/movies'

          expect(page).to have_button("Top Rated Movies")
          expect(page).to have_field("Search")
          expect(page).to have_link("Gabriel's Inferno")
          # save_and_open_page
          within(first(".card-back")) do
            expect(page).to have_content("Vote average:")
        end
      end
      it "after clicking 'Search By Movie', I should see 40 results," do
        search1 = File.read('spec/fixtures/search_movies_1.json')
        search2 = File.read('spec/fixtures/search_movies_2.json')

        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&include_adult=false&language=en-US&page=1&query=Pirates").to_return(status: 200, body: search1)
        stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&include_adult=false&language=en-US&page=2&query=Pirates").to_return(status: 200, body: search2)

        visit "/discover"

        fill_in :search, with: 'Pirates'
        click_button 'Search'

        within(first(".card-back")) do
          expect(page).to have_content("Vote average:")
        end
      end
      it "after clicking 'Discover Current Popular Movies', I should see 40 results," do
        json1 = File.read('spec/fixtures/popular_movies_1.json')
        json2 = File.read('spec/fixtures/popular_movies_2.json')

        stub_request(:get, "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json1)
        stub_request(:get, "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2").to_return(status: 200, body: json2)

        visit "/discover"

        click_button "Discover Current Popular Movies"

        within(first('.cards'))
        within('.card-front')
        within('.card-inner')
          expect(page).to have_link()
        within(first(".card-back")) do
          expect(page).to have_content("Vote average:")
        end
      end
    end
  end
end
