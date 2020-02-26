# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Extractor do
  context 'Van Gogh paintings' do
    let(:expected_results_file_path) { File.expand_path('./spec/fixtures/corrected-expected-array.json') }
    let(:expected_results) { JSON.parse(File.read(expected_results_file_path)) }

    let(:van_gogh_paintings_path) { File.expand_path('./files/van-gogh-paintings.html') }
    let(:json_string) { Extractor.new(van_gogh_paintings_path).call }
    let(:extractor_results) { JSON.parse(json_string) }
    let(:first_artwork) { extractor_results['artworks'][0] }

    it 'should return a json string' do
      expect(json_string.class).to eq String
    end

    it "should have 'artworks' key" do
      expect(extractor_results.keys.include?('artworks')).to eq true
    end

    context 'First artwork' do
      it 'should be same as expected result first artwork' do
        expect(first_artwork).to eq expected_results['artworks'][0]
      end

      it 'should have a name' do
        aggregate_failures do
          expect(first_artwork['name']).to eq 'The Starry Night'
          expect(first_artwork['name']).to be_a(String)
          expect(first_artwork['name']).to_not be_empty
        end
      end

      it 'should have extensions' do
        aggregate_failures do
          expect(first_artwork['extensions']).to eq ['1889']
          expect(first_artwork['extensions']).to be_a(Array)
          expect(first_artwork['extensions']).to_not be_empty
        end
      end

      it 'should have a link' do
        aggregate_failures do
          expect(first_artwork['link']).to be_a(String)
          expect(first_artwork['link']).to_not be_empty
        end
      end

      it 'should have an image' do
        aggregate_failures do
          expect(first_artwork['image']).to be_a(String)
          expect(first_artwork['image']).to_not be_empty
        end
      end
    end
  end

  context 'Da Vinci paintings' do
    let(:da_vinci_paintings_path) { File.expand_path('./spec/fixtures/da-vinci-paintings.html') }
    let(:json_string) { Extractor.new(da_vinci_paintings_path).call }
    let(:extractor_results) { JSON.parse(json_string) }
    let(:first_artwork) { extractor_results['artworks'][0] }

    it 'should return a json string' do
      expect(json_string.class).to eq String
    end

    it "should have 'artworks' key" do
      expect(extractor_results.keys.include?('artworks')).to eq true
    end

    context 'First artwork' do
      it 'should have a name' do
        aggregate_failures do
          expect(first_artwork['name']).to eq 'Mona Lisa'
          expect(first_artwork['name']).to be_a(String)
          expect(first_artwork['name']).to_not be_empty
        end
      end

      it 'should have extensions' do
        aggregate_failures do
          expect(first_artwork['extensions']).to eq ['1503']
          expect(first_artwork['extensions']).to be_a(Array)
          expect(first_artwork['extensions']).to_not be_empty
        end
      end

      it 'should have a link' do
        aggregate_failures do
          expect(first_artwork['link']).to be_a(String)
          expect(first_artwork['link']).to_not be_empty
        end
      end

      it 'should have an image' do
        aggregate_failures do
          expect(first_artwork['image']).to be_a(String)
          expect(first_artwork['image']).to_not be_empty
        end
      end
    end
  end

  context 'Picasso paintings' do
    let(:picasso_paintings_path) { File.expand_path('./spec/fixtures/picasso-paintings.html') }
    let(:json_string) { Extractor.new(picasso_paintings_path).call }
    let(:extractor_results) { JSON.parse(json_string) }
    let(:first_artwork) { extractor_results['artworks'][0] }

    it 'should return a json string' do
      expect(json_string.class).to eq String
    end

    it "should have 'artworks' key" do
      expect(extractor_results.keys.include?('artworks')).to eq true
    end

    context 'First artwork' do
      it 'should have a name' do
        aggregate_failures do
          expect(first_artwork['name']).to eq 'Guernica'
          expect(first_artwork['name']).to be_a(String)
          expect(first_artwork['name']).to_not be_empty
        end
      end

      it 'should have extensions' do
        aggregate_failures do
          expect(first_artwork['extensions']).to eq ['1937']
          expect(first_artwork['extensions']).to be_a(Array)
          expect(first_artwork['extensions']).to_not be_empty
        end
      end

      it 'should have a link' do
        aggregate_failures do
          expect(first_artwork['link']).to be_a(String)
          expect(first_artwork['link']).to_not be_empty
        end
      end

      it 'should have an image' do
        aggregate_failures do
          expect(first_artwork['image']).to be_a(String)
          expect(first_artwork['image']).to_not be_empty
        end
      end
    end
  end
end
