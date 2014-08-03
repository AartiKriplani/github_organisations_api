require_relative '../../services/github_service'

describe GithubService do
  describe '#get_organization' do
    let(:response) { double('Response', code: 404) }
    before do
      allow_any_instance_of(RestClient::Resource).to receive(:get).and_return(response)
    end

    context 'when successful' do
      let(:response_body) { [{'name' => 'github-repo'}].to_json }
      let(:response) { double('Response', code: 200, body: response_body) }
      it 'returns the organization' do
        org_name = 'github'
        expected_organization = Organization.new(org_name, JSON.parse(response_body))
        expect(Organization).to receive(:new).with(org_name, JSON.parse(response_body)).and_return(expected_organization)

        organization = GithubService.new.get_organization(org_name)

        expect(organization).to eq expected_organization
      end
    end

    context 'when not successful' do
      let(:response) { double('Response', code: 404) }
      it 'returns null organization' do
        org_name = 'something'
        expected_organization = NullOrganization.new
        expect(NullOrganization).to receive(:new).and_return(expected_organization)

        organization = GithubService.new.get_organization(org_name)

        expect(organization).to eq expected_organization
      end
    end

    it 'uses the correct github api and options' do
      org_name = 'something'
      rest_client_resource = double(RestClient::Resource)

      expect(RestClient::Resource).to receive(:new).with('https://api.github.com/orgs', :verify_ssl => OpenSSL::SSL::VERIFY_NONE).and_return(rest_client_resource)
      expect(rest_client_resource).to receive(:[]).with("/#{org_name}/repos").and_return(rest_client_resource)
      expect(rest_client_resource).to receive(:get).and_return(response)

      GithubService.new.get_organization(org_name)
    end
  end
end