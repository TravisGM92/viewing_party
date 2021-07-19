class Review
  attr_reader :author,
              :content,
              :id,
              :url

  def initialize(attributes)
    @author = attributes[:author]
    @content = attributes[:content]
    @id = attributes[:id]
    @url = attributes[:url]
  end
end
