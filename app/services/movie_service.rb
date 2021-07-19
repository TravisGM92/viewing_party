class MovieService
  def self.faraday
    @page, @movie_results = 1, []
    Faraday.new(url: 'https://api.themoviedb.org')
  end

  def self.search_movies(keyword)
    page = 1
    until page == 2
      json = json_parse(faraday.get("/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&query=#{keyword}&page=#{page}&include_adult=false"))
      @movie_results << json[:results]
      page += 1
    end
    @movie_results.flatten
  end

  def self.get_40_movies(movie_count)
    movie_results = []
    until movie_results.length >= movie_count
      json = json_parse(faraday.get("/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=#{@page}"))
      json[:results].each { |f| movie_results << f }
      @page += 1
    end
    movie_results
  end

  def self.get_specific_movie(id)
    json_parse(faraday.get("/3/movie/#{id}?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US"))
  end

  def self.find_cast(id)
    json_parse(faraday.get("/3/movie/#{id}/credits?api_key=#{ENV['MOVIE_API_KEY']}"))
  end

  def self.find_reviews(id)
    json_parse(faraday.get("/3/movie/#{id}/reviews?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1"))
  end

  def self.recommendations(id)
    json_parse(faraday.get("/3/movie/#{id}/recommendations?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1"))
  end

  def self.popular(movie_count)
    movie_results = []
    until movie_results.length >= movie_count
      json = json_parse(faraday.get("/3/movie/popular?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=#{@page}"))
      json[:results].each { |f| movie_results << f }
      @page += 1
    end
    movie_results
  end

  def self.json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
