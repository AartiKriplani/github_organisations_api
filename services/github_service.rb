require 'rest_client'
require './models/organization'
require './models/null_organization'

class GithubService

  def get_org(org_name)
    response = RestClient.get "https://api.github.com/orgs/#{org_name}/repos"
    if response.code == 200
      orgs_data = JSON.parse(response.body)
      Organization.new(org_name, orgs_data)
    else
      NullOrganization.new
    end
  end

end