module SlackTransformer
  class Html
    class Paragraph
      attr_reader :input

      def initialize(input)
        @input = input
      end

      def to_slack
        input.gsub(/<p>/, "\n\n").gsub(/<\/p>/, "")
      end
    end
  end
end
