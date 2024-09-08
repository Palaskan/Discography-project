require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  let(:artist) { Artist.create!(name: "Metallica", description: "Metal band") }
  
  describe "GET #index" do
    it "assigns all artists to @artists" do
      get :index
      expect(assigns(:artists)).to include(artist)
    end

    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "assigns the correct artist to @artist" do
      get :show, params: { id: artist.id }
      expect(assigns(:artist)).to eq(artist)
    end

    it "responds successfully" do
      get :show, params: { id: artist.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "assigns a new artist to @artist" do
      get :new
      expect(assigns(:artist)).to be_a_new(Artist)
    end

    it "responds successfully" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "assigns the correct artist to @artist" do
      get :edit, params: { id: artist.id }
      expect(assigns(:artist)).to eq(artist)
    end

    it "responds successfully" do
      get :edit, params: { id: artist.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { { name: "New Artist", description: "New artist description" } }

      it "creates a new artist" do
        expect {
          post :create, params: { artist: valid_attributes }
        }.to change(Artist, :count).by(1)
      end

      it "redirects to the artist list" do
        post :create, params: { artist: valid_attributes }
        expect(response).to redirect_to(artists_url)
        expect(flash[:notice]).to eq("Artist was successfully created.")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: "", description: "No name provided" } }

      it "does not create a new artist" do
        expect {
          post :create, params: { artist: invalid_attributes }
        }.to_not change(Artist, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { artist: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let(:new_attributes) { { name: "Updated Artist", description: "Updated description" } }

    context "with valid parameters" do
      it "updates the artist" do
        patch :update, params: { id: artist.id, artist: new_attributes }
        artist.reload
        expect(artist.name).to eq("Updated Artist")
        expect(artist.description).to eq("Updated description")
      end

      it "redirects to the artist list" do
        patch :update, params: { id: artist.id, artist: new_attributes }
        expect(response).to redirect_to(artists_url)
        expect(flash[:notice]).to eq("Artist was successfully updated.")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: "", description: "No name provided" } }

      it "does not update the artist" do
        original_name = artist.name
        patch :update, params: { id: artist.id, artist: invalid_attributes }
        artist.reload
        expect(artist.name).to eq(original_name)
      end

      it "re-renders the 'edit' template" do
        patch :update, params: { id: artist.id, artist: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the artist and associated LPs" do
      artist.lps.create!(name: "Black Album", description: "Famous album")
      expect {
        delete :destroy, params: { id: artist.id }
      }.to change(Artist, :count).by(-1).and change(Lp, :count).by(-1)
    end

    it "redirects to the artist list" do
      delete :destroy, params: { id: artist.id }
      expect(response).to redirect_to(artists_url)
      expect(flash[:notice]).to eq("Artist was successfully destroyed.")
    end
  end
end
