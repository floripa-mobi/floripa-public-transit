# encoding: UTF-8

require 'spec_helper'

describe "bus_crawler" do
  describe "when fetching the data of a bus" do
    subject { FloripaPublicTransit::BusCrawler.new('177').fetch }

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
      expect(subject.schedules[3].hours.length).to eq 28
      expect(subject.schedules[4].hours.length).to eq 18
      expect(subject.schedules[5].hours.length).to eq 10

      expect(subject.schedules[3].hours[0]).to eq '06:09'
      expect(subject.schedules[4].hours[17]).to eq '23:55'
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
      expect(subject.schedules[0].origin).to eq 'TITRI'
      expect(subject.schedules[0].destination).to eq 'TITRI'

      expect(subject.schedules[3].origin).to eq 'TITRI'
      expect(subject.schedules[3].destination).to eq 'TITRI'
    end

    it "should have the name of the bus" do
      expect(subject.name).to eq('SANTA MÔNICA')
    end

    it "should have the number" do
      expect(subject.number).to eq('177')
    end

    it "should have the itinerary" do
      expected_itinerary = [
        'TITRI',
        'AVENIDA PROFESSOR HENRIQUE DA SILVA FONTES',
        'AVENIDA DA SAUDADE',
        'RODOVIA SC 404',
        'AVENIDA MADRE BENVENUTA',
        'AVENIDA PROFESSOR HENRIQUE DA SILVA FONTES',
        'RUA OSMARINO DE DEUS CARDOSO',
        'AVENIDA MADRE BENVENUTA',
        'AVENIDA PROFESSOR HENRIQUE DA SILVA FONTES',
        'RUA PROFESSORA MARIA FLORA PAUSEWANG',
        'RUA ROBERTO SAMPAIO GONZAGA',
        'RUA LAURO LINHARES',
        'AVENIDA MADRE BENVENUTA',
        'AVENIDA PROFESSOR HENRIQUE DA SILVA FONTES',
        'RUA PROFESSORA MARIA FLORA PAUSEWANG',
        'AVENIDA PROFESSOR HENRIQUE DA SILVA FONTES',
        'RUA BYRON BARCELLOS',
        'RUA JOE COLLAÇO',
        'AVENIDA MADRE BENVENUTA',
        'RODOVIA SC 404',
        'ELEVADO DO ITACOROBI',
        'AVENIDA DA SAUDADE',
        'RUA LAURO LINHARES',
        'RUA PROFESSOR ENOÉ SCHUTEL',
        'RUA PROFESSOR ODILON FERNANDES',
        'TITRI'
      ]

      expect(subject.itinerary).to eq expected_itinerary
    end
  end
end
