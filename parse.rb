class Parse
  attr_reader :entries

  def initialize(file)
    check_file?(file)
    @entries = Hash.new { |key, array| key[array] = [] }

    File.open(file).each do |entry|
      page_title, ip_address = entry.split(/\s+/)
      @entries[page_title] << ip_address
    end
  end

  private

  def check_file?(path)
    raise "#{path} does not exist" unless File.exist? path
  end
end
