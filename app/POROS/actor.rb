class Actor
  attr_reader :cast_id,
              :character,
              :credit_id,
              :gender,
              :id,
              :name,
              :profile_path

  def initialize(attributes)
    @cast_id = attributes[:cast_id]
    @character = attributes[:character]
    @credit_id = attributes[:credit_id]
    @gender = attributes[:gender]
    @id = attributes[:id]
    @name = attributes[:name]
    @profile_path = attributes[:profile_path]
  end
end
