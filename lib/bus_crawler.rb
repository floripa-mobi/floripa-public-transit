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


Bus = Struct.new(:name, :itinerary, :schedules)


Schedule = Struct.new(:period, :hours, :direction, :origin, :destination)


class BusCrawler
  GOING = '1'
  RETURNING = '2'

  def initialize(bus_line_number)
    @bus_line_number = bus_line_number
  end

  def fetch
    name = fetch_name()
    itinerary = fetch_itinerary()
    going_schedule = fetch_hours(GOING, itinerary)
    returning_schedule = fetch_hours(RETURNING, itinerary)

    Bus.new(name, itinerary, [going_schedule, returning_schedule].flatten)
  end

  private

  attr_reader :bus_line_number

  def fetch_name
    request_data('1', 'iso8859-1').css('#titulo_pagina').first.content.gsub(/\(.+\)/, '').strip
  end

  def fetch_itinerary
    data = request_data '3'

    data.css('#conteudo_itinerario li').map do |address|
      address.content.gsub('» ', '').strip
    end
  end


  def fetch_hours(direction, itinerary)
    data = request_data direction, 'iso8859-1'
    origin = itinerary[direction == GOING ? 0 : itinerary.length-1]
    destination = itinerary[direction == GOING ? itinerary.length-1 : 0]

    data.css('.conteudo_abas_ext tr:last-child td').map.with_index do |period, index|
      hours = period.to_s.split('<br>').map do |hour|
        match = hour.match(/(\d\d:\d\d)/)
        match && match[0]
      end.compact

      Schedule.new(PERIODS[index], hours, direction == GOING ? 'going' : 'returning', origin, destination)
    end
  end


  def request_data(direction, encoding = 'utf-8')
    url = "http://www.pmf.sc.gov.br/servicos/index.php?pagina=onibuslinha&idLinha=#{bus_line_number}"
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({ 'passoGeral' => direction })

    response = http.request(request)

    Nokogiri::HTML(response.body, nil, encoding)
  end

end
