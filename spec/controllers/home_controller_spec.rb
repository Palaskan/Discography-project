require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:artist) { Artist.create!(name: "Metallica", description: "Metal band") }
  let(:lp1) { artist.lps.create!(name: "Black Album", description: "Famous album") }
  let(:lp2) { artist.lps.create!(name: "White Album", description: "Another famous album") }

  describe "GET #index" do
    it "assigns all LPs to @lps" do
      get :index
      expect(assigns(:lps)).to include(lp1, lp2)
    end

    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end
end
