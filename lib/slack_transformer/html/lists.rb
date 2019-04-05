require 'nokogiri'

module SlackTransformer
  class Html
    class Lists
      attr_reader :input

      def initialize(input)
        @input = input
      end

      def to_slack
        fragment = Nokogiri::HTML.fragment(input)

        fragment.children.each do |child|
          case child.name
          when 'ul'
            list = child.children.map do |c|
              next unless c.name == 'li'
              "• #{c.children.to_html}"
            end

            child.replace(list.join("\n"))
          when 'ol'
            counter = 0
            list = child.children.map do |c|
              next unless c.name == 'li'
              "#{counter = counter + 1}. #{c.children.to_html}"
            end

            child.replace(list.join("\n"))
          end
        end

        fragment.to_html
      end
    end
  end
end
