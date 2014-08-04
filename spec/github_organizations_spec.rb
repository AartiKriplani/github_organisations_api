require 'vcr'
require 'thor'
require 'timecop'

load File.dirname(__FILE__) + '/../github_organizations.thor'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end


describe GithubOrganizations do
  describe '#fetch_data' do
    before do
      Timecop.freeze(Time.local(2014,8,3,12,0,0))
    end

    after do
      Timecop.return
      orgs_file = File.dirname(__FILE__) + '/../org_data_1407047400.csv'
      File.delete(orgs_file) if File.exist?(orgs_file)
    end

    it 'writes data to console for organization that exists and empty line for non existent orgs' do
      VCR.use_cassette('successful_with_missing_org') do
        original_stdout = $stdout
        $stdout = fake = StringIO.new
        GithubOrganizations.new.fetch_data('goderma', 'non-existent')
        $stdout = original_stdout
        expect(fake.string).to eq "+--------------+----------------+---------------+\n|     Github repositories for organizations     |\n+--------------+----------------+---------------+\n| organization | repo           | repo language |\n+--------------+----------------+---------------+\n| goderma      | doctorapi-ruby | Ruby          |\n| goderma      | goderma-status | Ruby          |\n\n+--------------+----------------+---------------+\n"
      end
    end

    it 'writes data to file for organization that exists and empty line for non existent orgs' do
      VCR.use_cassette('successful_with_missing_org') do
        original_stdout = $stdout
        $stdout = StringIO.new
        GithubOrganizations.new.fetch_data('goderma', 'non-existent')
        $stdout = original_stdout
        csv_file = CSV.read("org_data_1407047400.csv")
        expect(csv_file).to eq [["organization", "repo", "repo language"], ["goderma", "doctorapi-ruby", "Ruby"], ["goderma", "goderma-status", "Ruby"], ["", "", ""]]
      end
    end
  end
end