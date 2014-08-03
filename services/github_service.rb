require 'rest_client'
require './models/organization'
require './models/null_organization'

class GithubService

  def get_organization(org_name)
    response = RestClient.get "https://api.github.com/orgs/#{org_name}/repos"
    return Organization.new(org_name, parsed_response(response)) if response.code == 200
    NullOrganization.new
  end

  def parsed_response(response)
    JSON.parse(response.body)
  end

end