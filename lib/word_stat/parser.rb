module WordStat
  class Parser
    def initialize(path)
      @csv = CSV.open(path, 'a')
      start_line = `wc -l #{path}`.to_i
      @word_list = File.read(WORDS_PATH).split(/\n/).drop(start_line)
      @proxy_list = File.read(GOOD_PROXY_PATH).split(/\n/)
      @proxy_iterator = @proxy_list.cycle
      set_proxy
    end

    def run
      progress = ProgressBar.create(title: 'Parsing', total: @word_list.length)
      @word_list.each do |word|
        data = query(word)
        @csv << [word, *data]
        progress.increment
      end
    end

    private

    def request(url)
      open(URI.escape(url), proxy: "http://#{@current_proxy}")
    rescue StandardError => e
      STDERR.puts "Error #{@current_proxy} - #{e.message}"
      set_proxy
      retry
    end

    def set_proxy
      @current_proxy = @proxy_iterator.next
    end
  end
end
