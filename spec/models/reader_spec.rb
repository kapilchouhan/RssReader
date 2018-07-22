require 'rails_helper'

describe Reader, type: :model do
  describe "associations" do
    it { should belong_to(:feed) }
  end
end
