require 'rails_helper'

RSpec.describe LpsController, type: :controller do
  let!(:artist) { Artist.create!(name: "Hetfield", description: "Example of description") }
  let!(:lp) { artist.lps.create!(name: "Black Album", description: "Famous album") }
  let(:valid_attributes) { { name: "New LP", description: "New LP description", artist_id: artist.id } }
  let(:invalid_attributes) { { name: "", description: "No name provided", artist_id: nil } }

  describe "GET #index" do
    it "assigns all LPs to @lps" do
      get :index
      expect(assigns(:lps)).to include(lp)
    end

    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end

    context "filtered by artist_id" do
      it "filters the LPs by artist_id" do
        get :index, params: { artist_id: artist.id }
        expect(assigns(:lps)).to eq([lp])
      end
    end

    context "filtered by artist_name" do
      let(:artist2) { Artist.create!(name: "Hammett", description: "Another artist description") }
      let(:lp2) { artist2.lps.create!(name: "Against", description: "Another album") }

      it "filters the LPs by artist_name" do
        get :index, params: { artist_name: "Hetfield" }
        expect(assigns(:lps)).to include(lp)
        expect(assigns(:lps)).to_not include(lp2)
      end
    end
  end

  describe "GET #show" do
    it "assigns the correct LP to @lp" do
      get :show, params: { id: lp.id }
      expect(assigns(:lp)).to eq(lp)
    end

    it "responds successfully" do
      get :show, params: { id: lp.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "assigns a new LP to @lp" do
      get :new
      expect(assigns(:lp)).to be_a_new(Lp)
    end

    it "loads all artists" do
      artist2 = Artist.create!(name: "Hammett", description: "Another artist description")
      get :new
      expect(assigns(:artists)).to include(artist, artist2)
    end

    it "responds successfully" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "assigns the correct LP to @lp" do
      get :edit, params: { id: lp.id }
      expect(assigns(:lp)).to eq(lp)
    end

    it "loads all artists" do
      artist2 = Artist.create!(name: "Hammett", description: "Another artist description")
      get :edit, params: { id: lp.id }
      expect(assigns(:artists)).to include(artist, artist2)
    end

    it "responds successfully" do
      get :edit, params: { id: lp.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new LP" do
        expect {
          post :create, params: { lp: valid_attributes }
        }.to change(Lp, :count).by(1)
      end

      it "redirects to the list of LPs" do
        post :create, params: { lp: valid_attributes }
        expect(response).to redirect_to(lps_url)
        expect(flash[:notice]).to eq("Lp was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new LP" do
        expect {
          post :create, params: { lp: invalid_attributes }
        }.to_not change(Lp, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { lp: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    it "updates the LP with valid parameters" do
      patch :update, params: { id: lp.id, lp: { name: "Updated LP", description: "Updated description" } }
      lp.reload
      expect(lp.name).to eq("Updated LP")
      expect(lp.description).to eq("Updated description")
    end

    it "does not update the LP with invalid parameters" do
      original_name = lp.name
      patch :update, params: { id: lp.id, lp: invalid_attributes }
      lp.reload
      expect(lp.name).to eq(original_name)
    end
  end

  describe "DELETE #destroy" do
    let!(:song1) { lp.songs.create!(name: "Enter Sandman", description: "Song description") }
    let!(:song2) { lp.songs.create!(name: "The Unforgiven", description: "Another song description") }

    it "deletes the LP and its associated songs" do
      expect {
        delete :destroy, params: { id: lp.id }
      }.to change(Lp, :count).by(-1).and change(Song, :count).by(-2)
    end

    it "redirects to the list of LPs" do
      delete :destroy, params: { id: lp.id }
      expect(response).to redirect_to(lps_url)
      expect(flash[:notice]).to eq("Lp was successfully destroyed.")
    end
  end
end
