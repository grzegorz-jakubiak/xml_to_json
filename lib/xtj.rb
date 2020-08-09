# typed: true
# frozen_string_literal: true

require 'sorbet-runtime'
require 'rexml/parsers/sax2parser'
require 'rexml/sax2listener'
require 'json'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  'xtj' => 'XTJ',
  'xml_tag' => 'XMLTag',
  'xml_handler' => 'XMLHandler'
)
loader.setup

module XTJ
  class Document
    extend T::Sig

    def initialize(xml_document)
      @document = xml_document
    end

    sig { returns(Hash) }
    def to_hash
      @to_hash ||= parse
    end

    sig { params(_args: T.untyped).returns(String) }
    def to_json(*_args)
      to_hash.to_json
    end

    private

    sig { returns(Hash) }
    def parse
      parser = REXML::Parsers::SAX2Parser.new(@document)
      handler = Handlers::XMLHandler.new
      parser.listen(handler)
      parser.parse
      handler.xml_hash
    end
  end
end
