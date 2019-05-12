module WordStat
  def self.merge_csv
    bukvarix = CSV.read(BUKVARIX_PATH)
    google = CSV.read(GOOGLE_PATH).to_h
    CSV.open('../data/complete.csv', 'w') do |csv|
      bukvarix.each { |word, *row| csv << [word, *row, google[word]] }
    end
  end
end
