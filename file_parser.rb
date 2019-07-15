require_relative 'parse'
require_relative 'view'

class FileParser
  attr_reader :view

  def initialize(file)
    parsed_file = Parse.new(file)
    entries = parsed_file.entries
    @view = View.new(entries)
  end

  def get_most_views
    @view.views(unique: false)
  end

  def get_unique_views
    @view.views(unique: true)
  end

  def get_page_unique_views(page)
    @view.views_indiv_page(page, unique: true)
  end

  def get_page_most_views(page)
    @view.views_indiv_page(page, unique: false)
  end
end
