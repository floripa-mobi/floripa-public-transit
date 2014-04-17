# encoding: UTF-8

require 'spec_helper'
require 'schedule_crawler'

describe "schedule_crawler" do
  describe "when fetching the data of a bus" do
    subject { ScheduleCrawler.fetch('177') }

    it "should contain three different schedules" do
      expect(subject.schedules.length).to eq 3
    end

    it "should have the periods" do
      expect(subject.schedules[0].period).to eq 'weekday'
      expect(subject.schedules[1].period).to eq 'saturday'
      expect(subject.schedules[2].period).to eq 'sunday'
    end

    it "should have the hours" do
      expect(subject.schedules[0].hours.length).to eq 28
      expect(subject.schedules[1].hours.length).to eq 18
      expect(subject.schedules[2].hours.length).to eq 10

      expect(subject.schedules[0].hours[0]).to eq '06:09'
      expect(subject.schedules[1].hours[17]).to eq '23:55'
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
