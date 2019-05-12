module WordStat
  class Parser
    def initialize(path)
      @path = path
      #@parser = self.class.to_s.downcase.gsub(/.*parser/, '').to_sym
      File.new(@path, 'w') unless @path.exist?
      @csv = CSV.open(@path, 'a')
      start_line = `wc -l #{@path}`.to_i
      @word_list = File.read(WORDS_PATH).split(/\n/).drop(start_line)
      @proxy_list = File.read(GOOD_PROXY_PATH).split(/\n/)
      set_proxy
    end

    def run
      progress = ProgressBar.create(title: 'Parsing', total: @word_list.length)
      @word_list.each do |word|
        page = parser(word)
        data = prepare(page)
        save(word, data)
        progress.increment
      end
    end

    private

    def parser(word)
      begin
        open(request(word), proxy: "http://#{@current_proxy}")
      rescue StandardError => e
        STDERR.puts "Error #{@current_proxy} - #{e.message}"
        set_proxy
        retry
      end
    end

    def set_proxy
      @proxy_counter ||= 0
      #@proxy_list.cycle { |proxy| @current_proxy = proxy }
      @current_proxy = @proxy_list[@proxy_counter]
      (@proxy_list.length - 1) > @proxy_counter ? @proxy_counter += 1 : @proxy_counter = 0
    end
  end
end
