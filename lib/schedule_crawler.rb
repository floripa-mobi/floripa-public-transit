require 'nokogiri'
require "net/http"
require 'open-uri'
require "uri"
require 'json'


Schedule = Struct.new(:period, :hours)


module ScheduleCrawler
  PERIODS = [
    'weekday',
    'saturday',
    'sunday'
  ]

  def self.fetch(bus_line_number)

    data = request_data bus_line_number

    data.css('.conteudo_abas_ext tr:last-child td').map.with_index do |period, index|
      hours = period.to_s.split('<br>').map do |hour|
        match = hour.match(/(\d\d:\d\d)/)
        match && match[0]
      end.compact

      Schedule.new(PERIODS[index], hours)
    end

  end
end


def request_data(bus_line_number)
  url = "http://www.pmf.sc.gov.br/servicos/index.php?pagina=onibuslinha&idLinha=#{bus_line_number}"
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)

  request = Net::HTTP::Post.new(uri.request_uri)
  request.set_form_data({ 'passoGeral' => '2' })

  response = http.request(request)

  Nokogiri::HTML(response.body, nil, 'utf-8')
end
