module WordStat
  class ParserBukvarix
    def initialize
      File.new(BUKVARIX_PATH, 'w') unless BUKVARIX_PATH.exist?
      start_line = `wc -l #{BUKVARIX_PATH}`.to_i
      @word_list = File.read(WORDS).split(/\n/).drop(start_line)
      @proxy_list = File.read(GOOD_PROXY).split(/\n/)
      set_proxy
    end

    def run
      progress = ProgressBar.create(title: 'Parsing bukvarix', total: @word_list.length)
      @word_list.each do |word|
        data = parser(word)
        save(word, data)
        progress.increment
      end
    end

    private

    def parser(word)
      begin
        JSON.parse(open(request(word), proxy: "http://#{@current_proxy}").read)['data'].first
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

    def request(word)
      URI.escape("http://api.bukvarix.com/v1/keywords/?q=#{word}&api_key=free&num=1&format=json")
    end

    def save(word, data)
      CSV.open(BUKVARIX_PATH, 'a') do |csv|
        csv << if data.nil?
                 [word, 0, 0]
               else
                 [word, data[3], data[4]]
               end
      end
    end
  end
end
