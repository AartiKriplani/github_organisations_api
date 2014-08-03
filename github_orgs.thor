require 'thor'
require './services/github_service'
require './utils/file_handler'
require './utils/console_handler'

class GithubOrgs < Thor
	
	desc "fetch_data ORGS","Fetch organization's data from github"
	def fetch_data(*orgs)
		github_service = GithubService.new
		headers = ["organization", "repo", "repo language"]
		file_handler = FileHandler.new(headers, "test.csv")
		console_handler = ConsoleHandler.new(headers)
		
		orgs_data = orgs.map do |org_name|
			github_service.get_org org_name
		end

		console_handler.write(orgs_data)
		file_handler.write(orgs_data)
	end

end