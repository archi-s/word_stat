module WordStat
  class ProxyChecker
    def initialize
      @proxy_list = File.read(PROXY).split(/\n/)
    end

    def run
      progress = ProgressBar.create(title: 'Check proxy', total: @proxy_list.length)
      @proxy_list.map do |proxy|
        begin
          open('http://bukvarix.com', proxy: "http://#{proxy}")
        rescue StandardError => e
          puts "Error: #{proxy} - #{e.message}"
          @proxy_list.delete(proxy)
        end
        progress.increment
      end
      save
    end

    private

    def save
      File.open(GOOD_PROXY, 'w') { |f| @proxy_list.map { |proxy| f.write("#{proxy}\n") } }
    end
  end
end
