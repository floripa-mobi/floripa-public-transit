require 'spec_helper'
require 'schedule_crawler'

describe "schedule_crawler" do
  describe "when fetching the data of a bus" do
    subject { ScheduleCrawler.fetch('177') }

    it "should contain three different schedules" do
      expect(subject.length).to eq 3
    end

    it "should have the periods" do
      expect(subject[0].period).to eq 'weekday'
      expect(subject[1].period).to eq 'saturday'
      expect(subject[2].period).to eq 'sunday'
    end

    it "should have the hours" do
      expect(subject[0].hours.length).to eq 28
      expect(subject[1].hours.length).to eq 18
      expect(subject[2].hours.length).to eq 10

      expect(subject[0].hours[0]).to eq '06:09'
      expect(subject[1].hours[17]).to eq '23:55'
    end
  end
end
