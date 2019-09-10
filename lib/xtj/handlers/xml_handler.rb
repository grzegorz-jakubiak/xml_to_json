# typed: true
# frozen_string_literal: true

require 'rexml/sax2listener'

module XTJ
  module Handlers
    class XMLHandler
      include REXML::SAX2Listener
      include XTJ::Tags
      attr_reader :xml_hash

      def initialize
        @xml_hash = {}
        @stack = []
      end

      def start_element(_uri, _localname, qname, attributes)
        prefixed_attributes = attributes
                              .transform_keys { |key| "_#{key}".to_sym }
        element = XMLTag.new(tag: qname.to_sym, attributes: prefixed_attributes)
        @stack.prepend(element)
      end

      def end_element(_uri, _localname, _qname)
        if @stack.length > 1
          child = @stack.shift
          parent = @stack.shift
          parent.add_to_attributes(child.tag, child.attributes)
          @stack.prepend(parent)
        else
          element = @stack.shift
          @xml_hash[element.tag] = element.attributes
        end
      end

      def characters(text)
        return if text.strip.empty?
        raise REXML::ParseException, 'Invalid XML' if @stack.empty?

        element = @stack.shift
        element.attributes[:@text] = text
        @stack.prepend(element)
      end
    end
  end
end
