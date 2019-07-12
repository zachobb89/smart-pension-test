require_relative 'parse'
require_relative 'views'

class FileParser
  def initialize(file)
    parsed_file = Parse.new(file)
    entries = parsed_file.entries
    @views = Views.new(entries)
  end

  def most_views
    @views.most_views
  end

  def unique_views
    @views.unique_views
  end
end
