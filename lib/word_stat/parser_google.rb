module WordStat
  class ParserGoogle < Parser
    def initialize
      super(GOOGLE_PATH)
    end

    private

    def parser(word)
      super { prepare(Nokogiri::HTML(open(request(word)))) }
    end

    def request(word)
      super { "http://google.com/search?q=\"#{word}\"" }
    end

    def prepare(page)
      page.css('#resultStats').children.to_s
          .encode('UTF-16be', invalid: :replace, replace: '')
          .encode('UTF-8').gsub(/.*:/, '').to_i
    end

    def save(word, data)
      data.nil? ? super { [word, 0] } : super { [word, data] }
    end
  end
end
