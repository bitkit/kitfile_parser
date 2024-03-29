module KitfileParser
  class Kitfile
    class Node
      DEFAULT_INITIAL_CONCURRENCY = 0

      attr_reader :platform
      attr_reader :name
      attr_reader :command
      attr_reader :initial_concurrency
      attr_reader :routes
      
      def initialize(platform, name, command, initial_concurrency = nil)
        @platform = platform.to_sym
        @name = name.to_sym
        @command = command
        @initial_concurrency = (initial_concurrency || DEFAULT_INITIAL_CONCURRENCY).to_i
        @routes = []
      end

      def route(route)
        @routes << route
      end
    end
  end
end
