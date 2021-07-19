require 'rails_helper'

RSpec.describe 'Movie Facade' do
  it 'returns a list of movies for a given query' do
    search1 = File.read('spec/fixtures/search_movies_1.json')
    search2 = File.read('spec/fixtures/search_movies_2.json')

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&include_adult=false&language=en-US&page=1&query=Pirates").to_return(status: 200, body: search1)
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&include_adult=false&language=en-US&page=2&query=Pirates").to_return(status: 200, body: search2)

    keyword = 'Pirates'
    movies = MoviesFacade.search_movies(keyword)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(Movie)
    expect(movies.first.title).to be_a(String)
  end

  it 'returns a list of top 40 rated movies' do
    json1 = File.read('spec/fixtures/top_40_movies_1.json')
    json2 = File.read('spec/fixtures/top_40_movies_2.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json1)
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2").to_return(status: 200, body: json2)

    movie_count = 40
    movies = MoviesFacade.get_list_movies(movie_count)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(Movie)
    expect(movies.first.title).to be_a(String)
  end

  it 'returns a list of details for a given movie' do
    first_movie = JSON.parse(File.read('spec/fixtures/first_movie_link.json'), symbolize_names: true)
    first_movie_cast = JSON.parse(File.read('spec/fixtures/first_movie_cast.json'), symbolize_names: true)

    first_movie_reviews = JSON.parse(File.read('spec/fixtures/first_movie_reviews.json'), symbolize_names: true)
    json5 = File.read('spec/fixtures/first_movie_reviews.json')
    json1 = File.read('spec/fixtures/top_40_movies_1.json')
    json2 = File.read('spec/fixtures/top_40_movies_2.json')
    json3 = File.read('spec/fixtures/first_movie_link.json')
    json4 = File.read('spec/fixtures/first_movie_cast.json')


    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json1)
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2").to_return(status: 200, body: json2)
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{first_movie[:id]}?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US").to_return(status: 200, body: json3)
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{first_movie[:id]}/credits?api_key=#{ENV['MOVIE_API_KEY']}").to_return(status: 200, body: json4)
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{first_movie[:id]}/reviews?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json5)

    movie = MoviesFacade.get_specific_movie(first_movie[:id])

    expect(movie).to be_a(Movie)
    expect(movie.title).to be_a(String)
  end

  it 'returns a list of 40 current popular movies' do
    json1 = File.read('spec/fixtures/popular_movies_1.json')
    json2 = File.read('spec/fixtures/popular_movies_2.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").
        to_return(status: 200, body: json1)
    stub_request(:get, "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2").
        to_return(status: 200, body: json2)

    movie_count = 40
    movies = MoviesFacade.get_current_popular(movie_count)

    expect(movies).to be_an(Array)
    expect(movies.first).to be_a(Movie)
    expect(movies.first.title).to be_a(String)
  end

  it "can create movie objects" do
    search1 = File.read('spec/fixtures/search_movies_1.json')
    search2 = File.read('spec/fixtures/search_movies_2.json')

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&include_adult=false&language=en-US&page=1&query=Pirates").to_return(status: 200, body: search1)
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&include_adult=false&language=en-US&page=2&query=Pirates").to_return(status: 200, body: search2)

    movie_search = JSON.parse(File.read('spec/fixtures/search_movies_1.json'), symbolize_names: true)[:results]
    objs = MoviesFacade.create_movie_objs(movie_search)

    objs.each do |movie|
      expect(movie.id).to be_an(Integer)
      expect(movie.overview).to be_a(String)
      expect(movie.release_date).to be_a(String)
      expect(movie.title).to be_a(String)
      expect(movie.vote_count).to be_an(Integer)
    end
  end

  it "can get a movie's info and turn it into a hash" do
    @user = User.create!(username: "eDog", email: "elah@email.com", password: "password")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    first_movie = JSON.parse(File.read('spec/fixtures/first_movie_link.json'), symbolize_names: true)
    first_movie_reviews = JSON.parse(File.read('spec/fixtures/first_movie_reviews.json'), symbolize_names: true)

    json5 = File.read('spec/fixtures/first_movie_reviews.json')
    json1 = File.read('spec/fixtures/top_40_movies_1.json')
    json2 = File.read('spec/fixtures/top_40_movies_2.json')
    json3 = File.read('spec/fixtures/first_movie_link.json')
    json4 = File.read('spec/fixtures/first_movie_cast.json')
    json9 = File.read('spec/fixtures/movie_recommendations.json')


    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json1)
    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2").to_return(status: 200, body: json2)
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{first_movie[:id]}?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US").to_return(status: 200, body: json3)
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{first_movie[:id]}/credits?api_key=#{ENV['MOVIE_API_KEY']}").to_return(status: 200, body: json4)
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{first_movie[:id]}/reviews?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json5)
    stub_request(:get, "https://api.themoviedb.org/3/movie/724089/recommendations?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1").to_return(status: 200, body: json9)

    movie_info = MoviesFacade.get_info(first_movie[:id])
    expect(movie_info).to have_key :movie
    expect(movie_info).to have_key :runtime
    expect(movie_info).to have_key :cast
    expect(movie_info).to have_key :recommendations
    expect(movie_info).to have_key :reviews
    expect(movie_info[:movie]).to be_a(Movie)
    expect(movie_info[:runtime]).to be_a(String)
    expect(movie_info[:cast][0]).to be_a(Actor)
    expect(movie_info[:runtime]).to be_a(String)
  end
end
