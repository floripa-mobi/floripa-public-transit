# encoding: UTF-8

require 'spec_helper'

describe "bus_crawler" do
  describe "when fetching the data of the 360 line" do
    subject { FloripaPublicTransit::BusCrawler.new('360').fetch }

    it "should work (was breaking because of encoding issues)" do
      expect(subject.name).to eq 'BARRA DA LAGOA'
    end
  end
end
