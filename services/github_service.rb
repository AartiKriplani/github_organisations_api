require 'rest_client'
require './models/organization'
require './models/null_organization'

class GithubService

  def get_organization(org_name)
    response = RestClient::Request.execute(:verify_ssl => OpenSSL::SSL::VERIFY_NONE, 
      :url => "https://api.github.com/orgs/#{org_name}/repos", 
      :method => :get,
      :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
    return Organization.new(org_name, parsed_response(response)) if response.code == 200
    NullOrganization.new
  end

  private

  def parsed_response(response)
    JSON.parse(response.body)
  end
end