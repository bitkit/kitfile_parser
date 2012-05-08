require 'kitfile_parser/kitfile'

module KitfileParser
  def self.parse(source)
    Kitfile.from_source source
  end
end
