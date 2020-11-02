class MoviesFacade
  def self.search_movies(keyword)
    results = MovieService.search_movies(keyword)
    create_movie_objs(results)
  end


  def self.create_movie_objs(results)
    array = []
    results.map do |data|
      array << CreateMovie.new(data)
    end
    array
  end

  def self.create_one_movie_obj(data)
    CreateMovie.new(data)
  end

  def self.get_list_movies(movie_count)
    movie_results = MovieService.get_40_movies(movie_count)
    create_movie_objs(movie_results)
  end

  def self.get_specific_movie(id)
    movie = MovieService.get_specific_movie(id)
    create_one_movie_obj(movie)
  end

  def self.find_cast(id)
    result = MovieService.find_cast(id)[:cast]
    result.map do |member|
      CreateActor.new(member)
    end
  end

  def self.find_reviews(id)
    result = MovieService.find_reviews(id)
    return [] if result[:total_results] == []

    result[:results].map do |review|
      CreateReview.new(review)
    end
  end

  def self.find_recommendations(id)
    result = MovieService.recommendations(id)
    recommended = result[:results].map do |movie|
      CreateRecommendation.new(movie)
    end
    recommended[0..4]
  end

  def self.get_current_popular(movie_count)
    movie_results = MovieService.popular(movie_count)
    create_movie_objs(movie_results)
  end
end
