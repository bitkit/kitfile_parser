module KitfileParser
  class Kitfile
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
    
    class << self
      def from_source(source)
        # parsing happens here
        # new platform, name, command, initial_concurrency
      end
    end
  end
end
