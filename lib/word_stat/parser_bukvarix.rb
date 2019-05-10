module WordStat
  class ParserBukvarix < Parser
    def initialize
      super(BUKVARIX_PATH)
    end

    private

    def parser(word)
      super { JSON.parse(open(request(word), proxy: "http://#{@current_proxy}").read)['data'].first }
    end

    def request(word)
      super { "http://api.bukvarix.com/v1/keywords/?q=#{word}&api_key=free&num=1&format=json" }
    end

    def save(word, data)
      data.nil? ? super { [word, 0, 0] } : super { [word, data[3], data[4]] }
    end
  end
end
