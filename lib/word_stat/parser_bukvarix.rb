module WordStat
  class ParserBukvarix < Parser
    def initialize
      super(BUKVARIX_PATH)
    end

    private

    def prepare(page)
      JSON.parse(page.read)['data'].first
    end

    def request(word)
      URI.escape("http://api.bukvarix.com/v1/keywords/?q=#{word}&api_key=free&num=1&format=json")
    end

    def save(word, data)
      @csv << if data.nil?
                  [word, 0, 0]
                else
                  [word, data[3], data[4]]
                end
    end
  end
end
