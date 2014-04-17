$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'

require 'bus_list_crawler'
require 'bus_crawler'

module Crawler
  def self.fetch_all
    BusListCrawler.new.fetch.map do |bus_line_number|
      BusCrawler.new(bus_line_number).fetch
    end
  end
end
