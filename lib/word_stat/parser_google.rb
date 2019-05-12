module WordStat
  class ParserGoogle < Parser
    def initialize
      super(GOOGLE_PATH)
    end

    private

    def query(word)
      page = request(%(http://google.com/search?q="#{word}"))
      value = Nokogiri::HTML(page).css('#resultStats').children.to_s
                      .encode('UTF-16be', invalid: :replace, replace: '')
                      .encode('UTF-8').gsub(/.*:/, '').to_i
      return [0] unless value
      [value]
    end
  end
end
