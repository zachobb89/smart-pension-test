class View
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def views(unique)
    view_getter('Most Views Count', unique)
  end

  def views_indiv_page(page, unique)
    view = most_or_unique(unique)
    show_page_views(page, view)
  end

  private

  def most_or_unique(unique)
    create_count(unique).sort_by { |_page, ip| ip.size }.to_h
  end

  def show_page_views(page, view)
    view.slice(page)
  end

  def view_getter(title, unique)
    view = most_or_unique(unique)
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
    title.to_s
    list.each_with_index do |(page, count), _index|
      "#{page} - #{count}"
    end
  end
end
