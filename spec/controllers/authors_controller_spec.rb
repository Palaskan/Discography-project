require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let!(:author) { Author.create!(name: "Hetfield", description: "Author description") }
  let(:valid_attributes) { { name: "New Author", description: "Author description" } }
  let(:invalid_attributes) { { name: "", description: "No name provided" } }
  
  describe "GET #index" do
    it "assigns all authors to @authors" do
      get :index
      expect(assigns(:authors)).to include(author)
    end

    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "assigns the correct author to @author" do
      get :show, params: { id: author.id }
      expect(assigns(:author)).to eq(author)
    end

    it "responds successfully" do
      get :show, params: { id: author.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "assigns a new author to @author" do
      get :new
      expect(assigns(:author)).to be_a_new(Author)
    end

    it "responds successfully" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "assigns the correct author to @author" do
      get :edit, params: { id: author.id }
      expect(assigns(:author)).to eq(author)
    end

    it "responds successfully" do
      get :edit, params: { id: author.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new author" do
        expect {
          post :create, params: { author: valid_attributes }
        }.to change(Author, :count).by(1)
      end

      it "redirects to the newly created author" do
        post :create, params: { author: valid_attributes }
        expect(response).to redirect_to(author_url(Author.last))
        expect(flash[:notice]).to eq("Author was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new author" do
        expect {
          post :create, params: { author: invalid_attributes }
        }.to_not change(Author, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { author: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let(:new_attributes) { { name: "Updated Author", description: "Updated description" } }

    context "with valid parameters" do
      it "updates the author" do
        patch :update, params: { id: author.id, author: new_attributes }
        author.reload
        expect(author.name).to eq("Updated Author")
        expect(author.description).to eq("Updated description")
      end

      it "redirects to the author" do
        patch :update, params: { id: author.id, author: new_attributes }
        expect(response).to redirect_to(author_url(author))
        expect(flash[:notice]).to eq("Author was successfully updated.")
      end
    end

    context "with invalid parameters" do
      it "does not update the author" do
        original_name = author.name
        patch :update, params: { id: author.id, author: invalid_attributes }
        author.reload
        expect(author.name).to eq(original_name)
      end

      it "re-renders the 'edit' template" do
        patch :update, params: { id: author.id, author: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the author" do
      expect {
        delete :destroy, params: { id: author.id }
      }.to change(Author, :count).by(-1)
    end

    it "redirects to the authors list" do
      delete :destroy, params: { id: author.id }
      expect(response).to redirect_to(authors_url)
      expect(flash[:notice]).to eq("Author was successfully destroyed.")
    end

    it "does not delete associated songs" do
      artist = Artist.create!(name: "Metallica", description: "Example of description")
      lp = Lp.create!(name: "Black Album", description: "Example of description", artist: artist)
      song = Song.create!(name: "Enter Sandman", description: "Example of description", lp: lp)
      author.songs << song

      expect {
        delete :destroy, params: { id: author.id }
      }.to_not change(Song, :count)
    end
  end
end
