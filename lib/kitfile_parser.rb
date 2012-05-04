module KitfileParser
  def parse(source)
    Kitfile.from_source source
  end
  module_function :parse
end
