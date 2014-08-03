require 'rest_client'
require './models/organization'
require './models/null_organization'

class GithubService

  def initialize
    @github_api = RestClient::Resource.new("https://api.github.com/orgs", :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
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