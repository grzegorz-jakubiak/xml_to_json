# frozen_string_literal: true

require_relative 'xml_to_json/version'
require_relative 'xml_to_json/tags/xml_tag'
require_relative 'xml_to_json/handlers/xml_handler'
require 'rexml/parsers/sax2parser'
require 'json'

module XMLToJson
  class Document
    def initialize(xml_document)
      @document = xml_document
    end

    def to_hash
      @to_hash ||= parse
    end

    def to_json(*_args)
      to_hash.to_json
    end

    private

    def parse
      parser = REXML::Parsers::SAX2Parser.new(@document)
      handler = Handlers::XMLHandler.new
      parser.listen(handler)
      parser.parse
      handler.xml_hash
    end
  end
end
