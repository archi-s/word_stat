require 'csv'
require 'open-uri'
require 'json'
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
  DATA_PATH = Pathname.new('../data/')
  WORDS_PATH = DATA_PATH.join('words.txt')
  BUKVARIX_PATH = DATA_PATH.join('bukvarix.csv')
  GOOGLE_PATH = DATA_PATH.join('google.csv')
  PROXY_PATH = DATA_PATH.join('proxy.txt')
  GOOD_PROXY_PATH = DATA_PATH.join('good_proxy.txt')
end
