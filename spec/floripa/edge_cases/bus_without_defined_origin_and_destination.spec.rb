# encoding: UTF-8

require 'spec_helper'

describe "bus_crawler" do
  describe "when fetching the data of the a bus without defined origin or destination (like the 177)" do
    subject { FloripaPublicTransit::BusCrawler.new('177').fetch }

    it "should have the origin and destination taken from the itinerary" do
      expect(subject.schedules[0].origin).to eq 'TITRI'
      expect(subject.schedules[0].destination).to eq 'TITRI'
    end

    it "should only have schedules defined that have hours" do
      subject.schedules.each do |schedule|
        expect(schedule.hours.length).not_to eq 0
      end
    end
  end
end
