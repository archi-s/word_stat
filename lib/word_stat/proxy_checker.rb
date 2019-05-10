module WordStat
  class ProxyChecker
    def initialize
      @proxy_list = File.read(PROXY).split(/\n/)
    end

    def run
      progress = ProgressBar.create(title: 'Check proxy', total: @proxy_list.length)
      @proxy_list.each do |proxy|
        check_proxy(proxy)
        progress.increment
      end
      save
    end

    private

    def check_proxy(proxy)
      begin
        open('http://bukvarix.com', proxy: "http://#{proxy}")
      rescue StandardError => e
        puts "Error: #{proxy} - #{e.message}"
        @proxy_list.delete(proxy)
      end
    end

    def save
      File.open(GOOD_PROXY, 'w') { |f| @proxy_list.map { |proxy| f.write("#{proxy}\n") } }
    end
  end
end
