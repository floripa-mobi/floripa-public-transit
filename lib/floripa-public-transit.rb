$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))


require 'rubygems'
require 'bundler/setup'


require 'floripa/bus_list_crawler'
require 'floripa/bus_crawler'


module FloripaPublicTransit
  def self.fetch_all
    FloripaPublicTransit::BusListCrawler.new.fetch.map do |line_number|
      FloripaPublicTransit::BusCrawler.new(line_number).fetch
    end
  end

  def self.fetch_line(line_number)
    FloripaPublicTransit::BusCrawler.new(line_number).fetch
  end

  def self.fetch_line_numbers
    FloripaPublicTransit::BusListCrawler.new.fetch
  end
end
