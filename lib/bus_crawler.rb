# encoding: UTF-8

require 'nokogiri'
require "net/http"
require 'open-uri'
require "uri"
require 'json'

PERIODS = [
  'weekday',
  'saturday',
  'sunday'
]


Bus = Struct.new(:itinerary, :schedules)


Schedule = Struct.new(:period, :hours)


class BusCrawler
  def initialize(bus_line_number)
    @bus_line_number = bus_line_number
  end

  def fetch
    going_schedule = fetch_hours('1')
    returning_schedule = fetch_hours('2')
    itinerary = fetch_itinerary()

    Bus.new(itinerary, returning_schedule)
  end

  private

  attr_reader :bus_line_number

  def fetch_itinerary
    data = request_data '3'

    data.css('#conteudo_itinerario li').map do |address|
      address.content.gsub('» ', '').strip
    end
  end


  def fetch_hours(tab_number)
    data = request_data '2'

    data.css('.conteudo_abas_ext tr:last-child td').map.with_index do |period, index|
      hours = period.to_s.split('<br>').map do |hour|
        match = hour.match(/(\d\d:\d\d)/)
        match && match[0]
      end.compact

      Schedule.new(PERIODS[index], hours)
    end
  end


  def request_data(tab_number)
    url = "http://www.pmf.sc.gov.br/servicos/index.php?pagina=onibuslinha&idLinha=#{bus_line_number}"
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({ 'passoGeral' => tab_number })

    response = http.request(request)

    Nokogiri::HTML(response.body, nil, 'utf-8')
  end

end
