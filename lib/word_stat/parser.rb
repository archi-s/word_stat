
module WordStat
  class Parser
    def initialize(path)
      @path = path
      File.new(@path, 'w') unless @path.exist?
      start_line = `wc -l #{@path}`.to_i
      @word_list = File.read(WORDS).split(/\n/).drop(start_line)
      @proxy_list = File.read(GOOD_PROXY).split(/\n/)
      set_proxy
    end

    def run
      progress = ProgressBar.create(title: 'Parsing', total: @word_list.length)
      @word_list.each do |word|
        data = parser(word)
        save(word, data)
        progress.increment
      end
    end

    private

    def request(word)
      URI.escape(yield)
    end

    def parser(word)
      begin
        yield
      rescue StandardError => e
        puts "Error #{@current_proxy} - #{e.message}"
        set_proxy
        retry
      end
    end

    def set_proxy
      @proxy_counter ||= 0
      @current_proxy = @proxy_list[@proxy_counter]
      (@proxy_list.length - 1) > @proxy_counter ? @proxy_counter += 1 : @proxy_counter = 0
    end

    def save(word, data)
      CSV.open(@path, 'a') do |csv|
        csv << if data.nil?
                yield[:nil]
               else
                yield[:data]
               end
      end
    end
  end
end
