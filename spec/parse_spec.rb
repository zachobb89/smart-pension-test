require 'spec_helper'
require './file_parser'

RSpec.describe Parse do
  let(:file_path) { 'webserver_test.log' }
  subject { described_class.new(file_path) }

  describe '#new' do
    let(:file_path) { 'not_logfile.log' }
    context 'when initialized with an incorrect file' do
      it 'should produce an error' do
        expect { subject }.to raise_error(RuntimeError,
                                          "#{file_path} does not exist")
      end
    end
  end

  describe '#new' do
    let(:expected_results) do
      { '/index' => ['444.701.448.104', '316.433.849.805', '802.683.925.780',
                     '184.123.665.067'], '/about' => ['126.318.035.038'],
        '/home' => ['382.335.626.855', '802.683.925.780', '451.106.204.921',
                    '715.156.286.412'] }
    end

    context 'when initialized with a correct file' do
      it 'should produce a hash of titles and ip_addresses' do
        expect(subject.entries).to eq(expected_results)
      end
    end
  end
end
