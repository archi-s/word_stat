module WordStat
  class ParserBukvarix < Parser
    def initialize
      super(BUKVARIX_PATH)
    end

    private

    def query(word)
      response = request("http://api.bukvarix.com/v1/keywords/?q=#{word}&api_key=free&num=1&format=json")
      data = JSON.parse(response.read)['data'].first
      return [0, 0] unless data
      data.values_at(3, 4)
    end
  end
end
