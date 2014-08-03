require 'rest_client'
require './models/organization'
require './models/null_organization'

class GithubService
  GITHUB_API_URL = 'https://api.github.com/orgs'

  def initialize
    @github_api = RestClient::Resource.new(GITHUB_API_URL, :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
  end

  def get_organizations(organization_names)
    organization_names.map do |organization_name|
      get_organization organization_name
    end
  end

  private

  def get_organization(organization_name)
    response = @github_api["/#{organization_name}/repos"].get { |response, request, result| response }
    return Organization.new(organization_name, parsed_response(response)) if response.code == 200
    NullOrganization.new
  end

  def parsed_response(response)
    JSON.parse(response.body)
  end
end