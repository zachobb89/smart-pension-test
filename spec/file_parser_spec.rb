require 'spec_helper'
require './file_parser'

RSpec.describe FileParser do
  let(:file_path) { './spec/webserver_test.log' }
  subject { described_class.new(file_path) }

  describe '#new' do
    let(:expected_results) do
      { '/index' => ['444.701.448.104', '316.433.849.805', '802.683.925.780',
                     '184.123.665.067'], '/about' => ['126.318.035.038'],
        '/home' => ['382.335.626.855', '802.683.925.780', '451.106.204.921',
                    '715.156.286.412'] }
    end

    context 'when initialized with a correct file' do
      it 'should produce a hash of titles and ip_address' do
        expect(subject.view.entries.to_h).to eq(expected_results)
      end
    end
  end

  describe '#new' do
    let(:file_path) { 'not_file.log' }
    context 'when initialized with an incorrect file' do
      it 'should produce an error' do
        expect { subject }.to raise_error(RuntimeError,
                                          "#{file_path} does not exist")
      end
    end
  end

  describe '#most_viewed' do
    let(:expected_results) do
      [['/home', 4], ['/index', 4], ['/about', 1]]
    end

    context 'when most views is requested' do
      it 'should produce an ordered list of most views' do
        expect(subject.get_most_views).to eq(expected_results)
      end
    end
  end

  describe '#unique_views' do
    let(:expected_results) do
      [['/home', 4], ['/index', 4], ['/about', 1]]
    end

    context 'when unique views is requested' do
      it 'should produce an ordered list of unique views' do
        expect(subject.get_unique_views).to eq(expected_results)
      end
    end
  end

  describe '#get_page_unique_views' do
    let(:expected_result) do
      { '/home' => 4 }
    end

    context 'when unique views of a single page is requested' do
      it 'should produce a hash containing the page and the view count' do
        expect(subject.get_page_unique_views('/home')).to eq(expected_result)
      end
    end
  end

  describe '#get_page_most_views' do
    let(:expected_result) do
      { '/home' => 4 }
    end

    context 'when total views of a single page is requested' do
      it 'should produce a hash containing the page and the view count' do
        expect(subject.get_page_most_views('/home')).to eq(expected_result)
      end
    end
  end
end
