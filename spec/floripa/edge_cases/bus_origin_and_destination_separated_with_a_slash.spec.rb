# encoding: UTF-8

require 'spec_helper'

describe "bus_crawler" do
  describe "when fetching the data of the a bus where the origin/destination separator is a slash (like the 276)" do
    subject { FloripaPublicTransit::BusCrawler.new('276').fetch }

    it "should have the origin and destination taken from the itinerary" do
      expect(subject.schedules[0].origin).to eq 'TICAN'
      expect(subject.schedules[0].destination).to eq 'TICAN'
    end
  end
end
