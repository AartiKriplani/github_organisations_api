require 'rest_client'
require './models/organization'
require './models/null_organization'

class GithubService

  def get_organization(org_name)
    response = RestClient.get "https://api.github.com/orgs/#{org_name}/repos"
    if response.code == 200
      Organization.new(org_name, parsed_response(response))
    else
      NullOrganization.new
    end
  end

  def parsed_response(response)
    JSON.parse(response.body)
  end

end