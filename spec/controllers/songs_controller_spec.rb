require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  let(:artist) { Artist.create!(name: "Hetfield", description: "Example description") }
  let(:lp) { artist.lps.create!(name: "Black Album", description: "Album description") }
  let(:author) { Author.create!(name: "Hetfield", description: "Author description") }
  let!(:song) { lp.songs.create!(name: "Enter Sandman", description: "Song description") }
  let(:valid_attributes) { { name: "New Song", description: "New song description", lp_id: lp.id, author_ids: [author.id] } }
  let(:invalid_attributes) { { name: "", description: "No name provided", lp_id: nil, author_ids: [] } }

  describe "GET #index" do
    it "assigns all songs to @songs" do
      get :index
      expect(assigns(:songs)).to include(song)
    end

    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "assigns the correct song to @song" do
      get :show, params: { id: song.id }
      expect(assigns(:song)).to eq(song)
    end

    it "responds successfully" do
      get :show, params: { id: song.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "assigns a new song to @song" do
      get :new
      expect(assigns(:song)).to be_a_new(Song)
    end

    it "loads all LPs and authors" do
      author2 = Author.create!(name: "Jason N", description: "Author description 2")
      get :new
      expect(assigns(:lps)).to include(lp)
      expect(assigns(:authors)).to include(author, author2)
    end

    it "responds successfully" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "assigns the correct song to @song" do
      get :edit, params: { id: song.id }
      expect(assigns(:song)).to eq(song)
    end

    it "loads all LPs and authors" do
      author2 = Author.create!(name: "Jason N", description: "Author description 2")
      get :edit, params: { id: song.id }
      expect(assigns(:lps)).to include(lp)
      expect(assigns(:authors)).to include(author, author2)
    end

    it "responds successfully" do
      get :edit, params: { id: song.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new song" do
        expect {
          post :create, params: { song: valid_attributes }
        }.to change(Song, :count).by(1)
      end

      it "associates the song with the authors" do
        post :create, params: { song: valid_attributes }
        song = Song.last
        expect(song.authors).to include(author)
      end

      it "redirects to the newly created song" do
        post :create, params: { song: valid_attributes }
        expect(response).to redirect_to(song_url(Song.last))
        expect(flash[:notice]).to eq("Song was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new song" do
        expect {
          post :create, params: { song: invalid_attributes }
        }.to_not change(Song, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { song: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let(:new_author) { Author.create!(name: "Jason N", description: "Author description 2") }

    it "updates the song with valid parameters" do
      patch :update, params: { id: song.id, song: { name: "Updated Song", description: "Updated description", author_ids: [new_author.id] } }
      song.reload
      expect(song.name).to eq("Updated Song")
      expect(song.description).to eq("Updated description")
      expect(song.authors).to include(new_author)
    end

    it "does not update the song with invalid parameters" do
      original_name = song.name
      patch :update, params: { id: song.id, song: invalid_attributes }
      song.reload
      expect(song.name).to eq(original_name)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the song" do
      expect {
        delete :destroy, params: { id: song.id }
      }.to change(Song, :count).by(-1)
    end

    it "redirects to the list of songs" do
      delete :destroy, params: { id: song.id }
      expect(response).to redirect_to(songs_url)
      expect(flash[:notice]).to eq("Song was successfully destroyed.")
    end

    it "does not delete associated authors" do
      expect {
        delete :destroy, params: { id: song.id }
      }.to_not change(Author, :count)
    end
  end
end
