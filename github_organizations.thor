require 'thor'
require './services/github_service'
require './utils/file_handler'
require './utils/console_handler'
require './utils/outputter'

class GithubOrganizations < Thor

  desc 'fetch_data ORGANIZATION_NAMES', "Fetch organization's data from github"

  def fetch_data(*organization_names)
    Outputter.output(GithubService.new.get_organizations organization_names)
  end

end
