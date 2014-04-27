# encoding: UTF-8

require 'spec_helper'

describe "bus_crawler" do
  describe "when fetching the data of the M230 line" do
    subject { FloripaPublicTransit::BusCrawler.new('M230').fetch }

    it "should work (was breaking because of encoding issues)" do
      expect(subject.number).to eq 'M230'
    end
  end
end
