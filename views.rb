class Views
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def most_views
    most_views = create_count(unique: false).sort_by { |_page, ip| ip.size }.to_h
    @ordered_most_views = sorted_list(most_views)
    show_view(@ordered_most_views, 'Most Views Count')
  end

  def unique_views
    unique_views = create_count(unique: true).sort_by { |_page, ip| ip.size }.to_h
    @ordered_unique_views = sorted_list(unique_views)
    show_view(@ordered_unique_views, 'Unique Views Count')
  end

  private

  def create_count(unique:)
    @entries.each_with_object({}) do |(key, value), list|
      list[key] = unique ? value.uniq.size : value.size
      p key
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
