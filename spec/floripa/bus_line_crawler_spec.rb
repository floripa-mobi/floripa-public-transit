# encoding: UTF-8

require 'spec_helper'

describe "bus_list_crawler" do
  describe "when fetching the data of a lines" do
    subject { FloripaPublicTransit::BusListCrawler.new.fetch }

    it "should contain all bus line numbers" do
      expect(subject.length).to eq 255
      expect(subject).to include('330')
      expect(subject).to include('320')
      expect(subject).to include('D766')
    end
  end
end
