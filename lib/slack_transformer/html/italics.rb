module SlackTransformer
  class Html
    class Italics
      attr_reader :input

      def initialize(input)
        @input = input
      end

      def to_slack
        input.gsub(/<\/?em>/, '_')
      end
    end
  end
end
