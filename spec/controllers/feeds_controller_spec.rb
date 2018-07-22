require "rails_helper"

describe FeedsController do
  let(:feed) { FactoryGirl.create(:feed) }
  let(:another_feed) do 
    FactoryGirl.create(
      :feed,
      title: "Another Feed Title",
      url: "https://timesofindia.indiatimes.com/rssfeeds/-2128936835.cms"
    )
  end

  let(:feed_params) do
    {
      title: "Create Feed Title",
      url: "https://timesofindia.indiatimes.com/rssfeeds/-2128936835.cms",
      description: "Some Feed Description"
    }
  end
  describe "#index" do
    context "return all feed list" do
      it "return all feeds" do
        feed
        another_feed

        get :index
        expect(response.status).to eq(200)
        expect(assigns(:feeds).ids).to eq([feed.id, another_feed.id])
      end
    end
  end

  describe "#show" do
    context "feed show" do
      it "returns response" do
        get :show, params: { id: feed.id }
        
        expect(response.status).to eq(200)
        expect(assigns(:feed)).to have_attributes(
          id: feed.id,
          title: "Feed Title",
          url: "https://timesofindia.indiatimes.com/rssfeeds/1221656.cms",
          description: "Feed Description"
        )
      end
    end
  end

  describe "#edit" do
    context "when user, and attempting to edit feed" do
      it "it returns 200" do
        get :edit, params: { id: feed.id }
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#destroy" do
    context "when attempting to destroy feed" do
      it "returns 302" do
        delete :destroy, params: { id: feed.id }
        expect(response.status).to eq(302)
      end
    end
  end

  describe "#create" do
    it "when creating a feed" do
      
      post :create, params: { feed: feed_params }
      
      expect(Feed.last.title).to eq("Create Feed Title")
      expect(Feed.last.url).to eq("https://timesofindia.indiatimes.com/rssfeeds/-2128936835.cms")
      expect(Feed.last.description).to eq("Some Feed Description")
    end
  end
end
