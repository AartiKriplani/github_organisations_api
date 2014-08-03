require 'rest_client'
require './models/organization'
require './models/null_organization'

class GithubService
  GITHUB_API_URL = 'https://api.github.com/orgs'

  def initialize
    @github_api = RestClient::Resource.new(GITHUB_API_URL, :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
  end

  def get_organization(org_name)
    response = @github_api["/#{org_name}/repos"].get
    return Organization.new(org_name, parsed_response(response)) if response.code == 200
    NullOrganization.new
  end

  private

  def parsed_response(response)
    JSON.parse(response.body)
  end
end