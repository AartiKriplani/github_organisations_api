require_relative '../../utils/outputter'

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

    let(:org_1) { double('Organization', to_csv: [['Org1']]) }
    let(:org_2) { double('Organization', to_csv: [['Org2']]) }

    before(:each) do
      allow(CSV).to receive(:open)
      allow_any_instance_of(Terminal::Table).to receive(:to_s).and_return("tested")
    end

    it 'writes multiple organization to console' do
      organizations = [org_1,org_2]

      expect(Terminal::Table).to receive(:new).with(
        :title => 'Github repositories for organizations', 
        :headings => ['organization', 'repo', 'repo language'], 
        :rows => [['Org1'],['Org2']]).and_return('org_data')
      expect(Outputter).to receive(:puts).with('org_data')
      
      Outputter.output(organizations)
    end

  end
end
