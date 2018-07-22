require "rails_helper"
require "sidekiq/testing"

describe CreateReaderWorker do
  let(:feed) { FactoryGirl.create(:feed) }
  subject(:worker) do
    CreateReaderWorker.new.perform(feed.id)
  end

  describe "#perform" do
    context "when feed is created" do
      it "should create feed readers" do
        expect { worker }.to change { Reader.count }.by(20)   
      end
    end
  end
end
