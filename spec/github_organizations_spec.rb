require 'thor'
load File.dirname(__FILE__) + '/../github_organizations.thor'

describe GithubOrganizations do
  describe '#fetch_data' do
    GithubOrganizations.new.fetch_data('github', 'something')
  end
end