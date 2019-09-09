# typed: true
# frozen_string_literal: true

module XMLToJson
  module Tags
    class XMLTag
      attr_reader :tag, :attributes

      XMLToJson.sig {params(tag: Symbol, attributes: Hash).void}
      def initialize(tag:, attributes:)
        @tag = tag
        @attributes = attributes
      end

      XMLToJson.sig {params(tag: Symbol, attributes: Hash).void}
      def add_to_attributes(tag, attributes)
        if @attributes[tag].nil?
          @attributes[tag] = attributes
        elsif @attributes[tag].is_a?(Array)
          @attributes[tag] << attributes
        else
          same_tags = [@attributes[tag]]
          @attributes[tag] = same_tags << attributes
        end
      end
    end
  end
end
