module WordStat
  class ParserGoogle
    def initialize
      File.new(GOOGLE_PATH, 'w') unless GOOGLE_PATH.exist?
      start_line = `wc -l #{GOOGLE_PATH}`.to_i
      @word_list = File.read(WORDS).split(/\n/).drop(start_line)
      @proxy_list = File.read(GOOD_PROXY).split(/\n/)
      set_proxy
    end

    def run
      progress = ProgressBar.create(title: 'Parsing google', total: @word_list.length)
      @word_list.map do |word|
        begin
          data = prepare(Nokogiri::HTML(open(request(word), proxy: "http://#{@current_proxy}")))
        rescue StandardError => e
          puts "Error: #{@current_proxy} - #{e.message}"
          set_proxy
          retry
        end
        save(word, data)
        progress.increment
      end
    end

    private

    def set_proxy
      @proxy_counter ||= 0
      @current_proxy = @proxy_list[@proxy_counter]
      (@proxy_list.length - 1) > @proxy_counter ? @proxy_counter += 1 : @proxy_counter = 0
    end

    def prepare(page)
      page.css('#resultStats').children.to_s
          .encode('UTF-16be', invalid: :replace, replace: '')
          .encode('UTF-8').gsub(/.*:/, '').to_i
    end

    def request(word)
      URI.escape("http://google.com/search?q=\"#{word}\"")
    end

    def save(word, data)
      CSV.open(GOOGLE_PATH, 'a') do |csv|
        csv << if data.nil?
                 [word, 0]
               else
                 [word, data]
               end
      end
    end
  end
end
