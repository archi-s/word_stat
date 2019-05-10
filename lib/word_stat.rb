require 'csv'
require 'json'
require 'open-uri'
require 'ruby-progressbar'
require 'nokogiri'
require 'pathname'
require_relative 'word_stat/proxy_checker'
require_relative 'word_stat/parser'
require_relative 'word_stat/parser_bukvarix'
require_relative 'word_stat/parser_google'
require_relative 'word_stat/merge_csv'

module WordStat
  VERSION = '0.0.1'.freeze
  WORDS = Pathname.new('../data/words.txt')
  BUKVARIX_PATH = Pathname.new('../data/bukvarix.csv')
  GOOGLE_PATH = Pathname.new('../data/google.csv')
  PROXY = Pathname.new('../data/proxy.txt')
  GOOD_PROXY = Pathname.new('../data/good_proxy.txt')
end
