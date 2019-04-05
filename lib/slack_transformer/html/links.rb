module SlackTransformer
  class Html
    class Links
      attr_reader :input

      HTML_PATTERN = %r{
        <a
        (?:.*?)
        href=['"](.+?)['"]
        (?:.*?)>
        (.+?)
        </a>
      }x

      def initialize(input)
        @input = input
      end

      def to_slack
        sub_html_links(@input)
      end

      private

      def sub_html_links(string)
        string.gsub(HTML_PATTERN) do
          slack_link Regexp.last_match[1], Regexp.last_match[2]
        end
      end

      def slack_link(link, text=nil)
        "<#{link}" \
        "#{text && !text.empty? ? "|#{text}" : ''}" \
        ">"
      end
    end
  end
end
