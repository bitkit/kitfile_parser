require 'kitfile_parser/kitfile/node'

module KitfileParser
  class Kitfile
    class << self
      def from_source(source)
        # new platform, name, command, initial_concurrency
        kitfile = new
        current_node = nil
        source.split("\n").each_with_index do |line, idx|
          if line =~ ROUTE_LINE
            unless current_node
              raise ::ArgumentError, %{[kitfile_parser] Route on line #{idx} not part of a node}
            end
            # - myapp.com/*
            current_node.route $1
          elsif line =~ NODE_LINE
            # heroku/web(3): bundle exec rackup config.ru
            current_node = kitfile.node $1, $2, $4, $3
          end
        end
        kitfile
      end
    end

    ROUTE_LINE = /^\s*-\s*([^\s\#]+)/
    NODE_LINE = %r{^([^/]+)/([^\(:]+)\(?(\d*)\)?:\s*([^\#]+)$}

    attr_reader :nodes
    
    def initialize
      @nodes = {}
      yield self if block_given?
    end

    def node(platform, name, command, initial_concurrency = nil)
      node = Node.new platform, name, command, initial_concurrency
      raise ArgumentError, "Node names must be unique (duplicated: '#{name}')" if @nodes[name]
      @nodes[name] = node
      yield node if block_given?
      node
    end
  end
end
