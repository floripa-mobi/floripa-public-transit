# encoding: UTF-8

require 'spec_helper'

describe "bus_crawler" do
  describe "when fetching the data of a bus" do
    subject { FloripaPublicTransit::BusCrawler.new('330').fetch }

    it "should contain three different schedules" do
      expect(subject.schedules.length).to eq 6
    end

    it "should have the periods" do
      expect(subject.schedules[0].period).to eq 'weekday'
      expect(subject.schedules[1].period).to eq 'saturday'
      expect(subject.schedules[2].period).to eq 'sunday'
      expect(subject.schedules[3].period).to eq 'weekday'
      expect(subject.schedules[4].period).to eq 'saturday'
      expect(subject.schedules[5].period).to eq 'sunday'
    end

    it "should have the hours" do
      expect(subject.schedules[3].hours.length).to eq 47
      expect(subject.schedules[4].hours.length).to eq 46
      expect(subject.schedules[5].hours.length).to eq 35

      expect(subject.schedules[0].hours[0]).to eq '05:32'
      expect(subject.schedules[3].hours[0]).to eq '05:47'
    end

    it "should have the direction" do
      expect(subject.schedules[0].direction).to eq 'going'
      expect(subject.schedules[1].direction).to eq 'going'
      expect(subject.schedules[2].direction).to eq 'going'
      expect(subject.schedules[3].direction).to eq 'returning'
      expect(subject.schedules[4].direction).to eq 'returning'
      expect(subject.schedules[5].direction).to eq 'returning'
    end

    it "should have the origin and destination" do
      expect(subject.schedules[0].origin).to eq 'TILAG'
      expect(subject.schedules[0].destination).to eq 'TICEN'

      expect(subject.schedules[3].origin).to eq 'TICEN'
      expect(subject.schedules[3].destination).to eq 'TILAG'
    end

    it "should have the name of the bus" do
      expect(subject.name).to eq('LAGOA DA CONCEIÇÃO')
    end

    it "should have the number" do
      expect(subject.number).to eq('330')
    end

    it "should have the operator" do
      expect(subject.operator).to eq('TRANSOL TRANSPORTE COLETIVO LTDA')
    end

    it "should have the itinerary" do
      expected_itinerary = [
        'TICEN',
        'RUA PROCURADOR ABELARDO GOMES',
        'AVENIDA PAULO FONTES',
        'RUA DOUTOR ÁLVARO MILLEN DA SILVEIRA',
        'RUA DOUTOR JORGE DA LUZ FONTES',
        'RUA SILVA JARDIM',
        'AVENIDA MAURO RAMOS',
        'AVENIDA JORNALISTA RUBENS DE ARRUDA RAMOS',
        'RUA COMANDANTE CONSTANTINO NICOLAU SPYRIDES',
        'RUA DELMINDA SILVEIRA',
        'RUA IDALINA PEREIRA DOS SANTOS',
        'AVENIDA GOVERNADOR IRINEU BORNHAUSEN',
        'AVENIDA DA SAUDADE',
        'RODOVIA ADMAR GONZAGA',
        'AVENIDA AFONSO DELAMBERT NETO',
        'TILAG',
        'TILAG',
        'AVENIDA AFONSO DELAMBERT NETO',
        'RODOVIA SC 404',
        'ELEVADO DO ITACOROBI',
        'AVENIDA DA SAUDADE',
        'RUA DELMINDA SILVEIRA',
        'RUA RUI BARBOSA',
        'RUA FREI CANECA',
        'RUA HEITOR LUZ',
        'AVENIDA MAURO RAMOS',
        'RUA SILVA JARDIM',
        'AVENIDA GOVERNADOR GUSTAVO RICHARD',
        'TICEN'
      ]

      expect(subject.itinerary).to eq expected_itinerary
    end
  end
end
