# encoding: UTF-8

require 'spec_helper'
require 'bus_crawler'

describe "bus_crawler" do
  describe "when fetching the data of a bus" do
    subject { BusCrawler.new('360').fetch }

    it "should work (was breaking because of encoding issues)" do
      expect(subject.name).to eq 'BARRA DA LAGOA'
    end
  end
end
