require_relative '../../utils/outputter'

describe Outputter do
  it "has headers to output" do
    expected_headers = ['organization', 'repo', 'repo language']
    expect(Outputter.headers).to eq expected_headers
  end

  it "generates a dynamic filename" do
    now_stub = double('now')
    allow(now_stub).to receive(:to_i) { 123456 }
    expect(Time).to receive(:now) { now_stub }
    expected_filename = "org_data_123456.csv"
    expect(Outputter.filename).to eq expected_filename
  end

  describe '#output' do

    before(:each) do
      allow(Outputter).to receive(:write_to_file)
      allow(Outputter).to receive(:write_to_console)
    end

    it "writes to file" do
      organizations = [NullOrganization.new]
      expect(Outputter).to receive(:write_to_file).with(organizations)
      Outputter.output(organizations)
    end

    it "writes to console" do
      organizations = [NullOrganization.new]
      expect(Outputter).to receive(:write_to_console).with(organizations)
      Outputter.output(organizations)
    end
  end
end
