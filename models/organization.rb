require './models/repository'

class Organization

  attr_accessor :name, :repositories

  def initialize(name, repos_data)
    @name = name
    @repositories = repos_data.map {|repo_data| Repository.new repo_data}
  end

  def to_s
    @repositories.map do |repo|
      "#{name}\t#{repo.name}\t#{repo.language}"
    end.join("\n")
  end

  def to_csv
    @repositories.map do |repo|
      [
        name, 
        repo.name, 
        repo.language
      ]
    end
  end

end