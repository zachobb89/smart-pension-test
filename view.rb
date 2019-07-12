class View
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def most_views
    view_getter('Most Views Count', unique: false)
  end

  def unique_views
    view_getter('Unique Views Count', unique: true)
  end

  private

  def view_getter(title, unique)
    view = create_count(unique).sort_by { |_page, ip| ip.size }.to_h
    @ordered_view = sorted_list(view)
    show_view(@ordered_view, title)
  end

  def create_count(unique:)
    @entries.each_with_object({}) do |(key, value), list|
      list[key] = unique ? value.uniq.size : value.size
    end
  end

  def sorted_list(list)
    list.sort_by { |_k, v| v }.reverse
  end

  def show_view(list, title)
    puts title.to_s
    list.each_with_index do |(page, count), _index|
      puts "#{page} - #{count}"
    end
  end
end
