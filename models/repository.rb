class Repository
  
  attr_accessor :name, :language

  def initialize(data)
    @name = data["name"]
    @language = data["language"]
  end

end