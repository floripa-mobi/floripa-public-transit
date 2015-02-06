# encoding: UTF-8

require 'nokogiri'
require "net/http"
require 'open-uri'
require "uri"
require 'json'


module FloripaPublicTransit
  class BusListCrawler
    def fetch
      [
        *fetch_lines('4'),
        *fetch_lines('7'),
        *fetch_lines('8'),
        *fetch_lines('9'),
        *fetch_lines('10'),
        *fetch_lines('11'),
      ]
    end

    private

    def fetch_lines(company)
      uri = URI.parse('http://www.pmf.sc.gov.br/servicos/index.php?pagina=onibus&menu=2')

      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({ 'passoGeral' => '1', 'passoEmpresa' => '1', 'empresa' => company, 'opcao' => '1' })

      response = http.request(request)

      doc = Nokogiri::HTML(response.body, nil, 'utf-8')

      doc.css('ul.listagem a').collect do |link|
        link[:href].split("idLinha=").last.split("&menu=2").first.strip
      end
    end
  end
end
