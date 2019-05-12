module WordStat
  class ParserGoogle < Parser
    def initialize
      super(GOOGLE_PATH)
    end

    private

    def request(word)
      URI.escape("http://google.com/search?q=\"#{word}\"")
    end

    def prepare(page)
      Nokogiri::HTML(page).css('#resultStats').children.to_s
          .encode('UTF-16be', invalid: :replace, replace: '')
          .encode('UTF-8').gsub(/.*:/, '').to_i
    end

    def save(word, data)
      @csv << if data.nil?
                  [word, 0]
                else
                  [word, data]
                end
    end
  end
end
