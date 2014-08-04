require_relative '../../utils/outputter'
require 'timecop'

describe Outputter do
  it 'has headers to output' do
    expected_headers = ['organization', 'repo', 'repo language']
    expect(Outputter.headers).to eq expected_headers
  end

  it 'generates a dynamic filename' do
    now_stub = double('now')
    allow(now_stub).to receive(:to_i) { 123456 }
    expect(Time).to receive(:now) { now_stub }
    expected_filename = 'org_data_123456.csv'
    expect(Outputter.filename).to eq expected_filename
  end

  describe '#output' do

    let(:org_1) { double('Organization', to_csv_rows: [['Org1','repo1']]) }
    let(:org_2) { double('Organization', to_csv_rows: [['Org2','repo2']]) }
    let(:mock_csv) { double('csv') }

    before(:each) do
      @csv_rows = []
      allow(CSV).to receive(:open).and_yield(@csv_rows)
      allow(Outputter).to receive(:puts)
    end

    it "writes repositories to csv file" do
      organizations = [org_1,org_2]
      Outputter.output(organizations)
      expect(@csv_rows).to eq([["organization", "repo", "repo language"], ["Org1", "repo1"], ["Org2", "repo2"]])
    end

    it 'writes multiple organization to console' do
      organizations = [org_1,org_2]

      expect(Terminal::Table).to receive(:new).with(
        :title => 'Github repositories for organizations', 
        :headings => ['organization', 'repo', 'repo language'], 
        :rows => [['Org1','repo1'],['Org2','repo2']]).and_return('org_data')
      expect(Outputter).to receive(:puts).with('org_data')
      
      Outputter.output(organizations)
    end

  end
end
