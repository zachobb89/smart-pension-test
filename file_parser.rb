require_relative 'parse'
require_relative 'view'

class FileParser
  def initialize(file)
    parsed_file = Parse.new(file)
    entries = parsed_file.entries
    @view = View.new(entries)
  end

  def get_most_views
    @view.most_views
  end

  def get_unique_views
    @view.unique_views
  end
end
