module KitfileParser
  class Kitfile
    class Node
      DEFAULT_INITIAL_CONCURRENCY = 0

      attr_reader :platform, :name, :command, :initial_concurrency, :routes
      
      def initialize(platform, name, command, initial_concurrency = nil)
        @platform = platform
        @name = name
        @command = command
        @initial_concurrency = initial_concurrency || DEFAULT_INITIAL_CONCURRENCY
        @routes = []
      end

      def route(route)
        @routes << route
      end
    end
  end
end
