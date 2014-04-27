# encoding: UTF-8

require 'spec_helper'

describe "bus_crawler" do
  describe "when fetching the data of a Cooperbarco operator" do
    subject { FloripaPublicTransit::BusCrawler.new('10').fetch }

    it "should work (was breaking because of encoding issues)" do
      expect(subject.operator).to eq 'HIDROVIÁRIO COOPERBARCO'
    end
  end
end
