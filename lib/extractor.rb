# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default)

# This class extracts carousel data from a google search html page
class Extractor
  BASE_URL = 'https://www.google.com'

  attr_accessor :document, :carousel_nodes

  def initialize(file_path)
    @document = Nokogiri::HTML(File.open(file_path))
    @carousel_nodes = document.css('.klitem-tr')
  end

  def call
    {
      artworks: carousel_nodes.map { |carousel_node| extract_carousel_data(carousel_node) }
    }.to_json
  end

  private

  def extract_carousel_data(carousel_node)
    {
      name: extract_name(carousel_node),
      extensions: extract_extensions(carousel_node),
      link: extract_link(carousel_node),
      image: extract_image(carousel_node)
    }
  end

  def extract_name(carousel_node)
    carousel_node.css('.kltat').children.map(&:text).join('')
  end

  def extract_extensions(carousel_node)
    carousel_node.css('.klmeta').children.map(&:text)
  end

  def extract_link(carousel_node)
    return unless carousel_node.css('.klitem').attribute('href')

    "#{BASE_URL}#{carousel_node.css('.klitem').attribute('href').value}"
  end

  def extract_image(carousel_node)
    img_id = carousel_node.css('.klic img').attribute('id').value
    regex = "var s='{1}(.*)'\;var ii=\\['#{img_id}'\\]{1}"
    matched_results = document.inner_html[/#{regex}/, 1]

    return unless matched_results

    base64_string = 'data:image' + matched_results.split('data:image')[-1]
    sanitize_base64_string(base64_string)
  end

  # This is to sanitize some trailing '/' characters in the image string
  def sanitize_base64_string(base64_string)
    array_string = base64_string.split('//')
    array_string[-1] = array_string[-1].gsub('\\', '')
    array_string.join('//')
  end
end
