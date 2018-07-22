require 'rails_helper'

describe Feed, type: :model do
  describe "validations" do
    let(:feed) { FactoryGirl.create(:feed) }

    it { should validate_presence_of(:url) }

    it "validates uniqueness of url" do
      another_feed = FactoryGirl.build(:feed, url: feed.url)
      expect(another_feed).not_to be_valid
    end

    it "validates format of url" do
      feed = FactoryGirl.build(:feed, url: "test_feed_url")
      expect(feed.valid?).to eq(false)
      expect(feed.errors[:url]).to include("is invalid")
    end
  end

  describe "associations" do
    it { should have_many(:readers) }
    it { should have_many(:readers).dependent(:destroy) }
  end

  describe "#strip_url" do
    it "strip url" do
      feed = FactoryGirl.build(:feed, url: "    test_feed_url    ")
      expect(feed.send(:strip_url)).to eq("test_feed_url")
    end
  end
end
