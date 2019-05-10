module WordStat
  def self.merge_csv
    bukvarix = []
    CSV.foreach(BUKVARIX_PATH) do |v|
      bukvarix << [v[0], v[1], v[2]]
    end

    google = []
    CSV.foreach(GOOGLE_PATH) do |v|
      google << [v[0], v[1]]
    end

    bukvarix.map do |b|
      gog = google.select do |g|
        g[0] == b[0]
      end
      CSV.open('../data/complete.csv', 'a') do |csv|
        csv << [b[0], b[1], b[2], gog[0][1]]
      end
    end

  end
end
