require './models/repository'

class Organization

  attr_accessor :name, :repositories

  def initialize(name, repos_data)
    @name = name
    @repositories = repos_data.map { |repo_data| Repository.new repo_data }
  end

  def to_csv_rows
    repositories.map do |repo|
      [
        name,
        repo.name,
        repo.language
      ]
    end
  end

end