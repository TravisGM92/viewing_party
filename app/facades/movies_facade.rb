class MoviesFacade
  def self.get_info(id)
    movie = get_specific_movie(id)
    MovieInfo.convert(movie, MovieStats.calculate_time(movie), find_cast(id), find_recommendations(id), find_reviews(id))
  end

  def self.search_movies(keyword)
    create_movie_objs(MovieService.search_movies(keyword))
  end

  def self.create_movie_objs(results, movies=[])
    results.map do |data|
      movies << Movie.new(data)
    end
    movies
  end

  def self.get_list_movies(movie_count)
    create_movie_objs(MovieService.get_40_movies(movie_count))
  end

  def self.get_specific_movie(id)
    Movie.new(MovieService.get_specific_movie(id))
  end

  def self.find_cast(id)
    MovieService.find_cast(id)[:cast][0..9].map do |member|
      Actor.new(member)
    end
  end

  def self.find_reviews(id)
    result = MovieService.find_reviews(id)
    return [] if result[:total_results] == []

    result[:results].map do |review|
      Review.new(review)
    end
  end

  def self.find_recommendations(id)
    recommended = MovieService.recommendations(id)[:results].map do |movie|
      Recommendation.new(movie)
    end
    recommended[0..4]
  end

  def self.get_current_popular(movie_count)
    create_movie_objs(MovieService.popular(movie_count))
  end
end
