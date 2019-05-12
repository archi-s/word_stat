module WordStat
  class ProxyChecker
    def initialize
      @proxy_list = File.read(PROXY_PATH).split(/\n/)
    end

    def run
      progress = ProgressBar.create(title: 'Check proxy', total: @proxy_list.length)
      @proxy_list.each do |proxy|
        check_proxy(proxy)
        progress.increment
      end
      File.write(GOOD_PROXY_PATH, @proxy_list.join("\n"))
    end

    private

    def check_proxy(proxy)
      open('http://bukvarix.com', proxy: "http://#{proxy}")
    rescue StandardError => e
      STDERR.puts "Error: #{proxy} - #{e.message}"
      @proxy_list.delete(proxy)
    end
  end
end
