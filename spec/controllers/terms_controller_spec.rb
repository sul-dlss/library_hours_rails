require 'rails_helper'

RSpec.describe TermsController, type: :controller do
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'with an anonymous user' do
    let(:user) { nil }
    let(:term) { create(:term) }

    it 'should deny access to #show' do
      expect { get :show, id: term, library_id: library, location_id: location }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #new' do
      expect { get :new, library_id: library, location_id: location }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #edit' do
      expect { get :edit, id: term, library_id: library, location_id: location }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #update' do
      expect { post :update, id: term, library_id: library, location_id: location }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #destroy' do
      expect { delete :destroy, id: term, library_id: library, location_id: location }.to raise_error CanCan::AccessDenied
    end
  end

  let(:user) { build(:superadmin_user) }
  let(:location) { create(:location) }
  let(:library) { location.library }

  # This should return the minimal set of attributes required to create a valid
  # Term. As you add validations to Term, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: 'Some Term' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TermsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all terms as @terms' do
      term = Term.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:terms)).to eq([term])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested term as @term' do
      term = Term.create! valid_attributes
      get :show, { id: term.to_param }, valid_session
      expect(assigns(:term)).to eq(term)
    end
  end

  describe 'GET #new' do
    it 'assigns a new term as @term' do
      get :new, {}, valid_session
      expect(assigns(:term)).to be_a_new(Term)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested term as @term' do
      term = Term.create! valid_attributes
      get :edit, { id: term.to_param }, valid_session
      expect(assigns(:term)).to eq(term)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Term' do
        expect do
          post :create, { term: valid_attributes }, valid_session
        end.to change(Term, :count).by(1)
      end

      it 'assigns a newly created term as @term' do
        post :create, { term: valid_attributes }, valid_session
        expect(assigns(:term)).to be_a(Term)
        expect(assigns(:term)).to be_persisted
      end

      it 'redirects to the created term' do
        post :create, { term: valid_attributes }, valid_session
        expect(response).to redirect_to(Term.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved term as @term' do
        post :create, { term: invalid_attributes }, valid_session
        expect(assigns(:term)).to be_a_new(Term)
      end

      it "re-renders the 'new' template" do
        post :create, { term: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'New Term Name' }
      end

      it 'updates the requested term' do
        term = Term.create! valid_attributes
        put :update, { id: term.to_param, term: new_attributes }, valid_session
        term.reload
        expect(term.name).to eq 'New Term Name'
      end

      it 'assigns the requested term as @term' do
        term = Term.create! valid_attributes
        put :update, { id: term.to_param, term: valid_attributes }, valid_session
        expect(assigns(:term)).to eq(term)
      end

      it 'redirects to the term' do
        term = Term.create! valid_attributes
        put :update, { id: term.to_param, term: valid_attributes }, valid_session
        expect(response).to redirect_to(term)
      end
    end

    context 'with invalid params' do
      it 'assigns the term as @term' do
        term = Term.create! valid_attributes
        put :update, { id: term.to_param, term: invalid_attributes }, valid_session
        expect(assigns(:term)).to eq(term)
      end

      it "re-renders the 'edit' template" do
        term = Term.create! valid_attributes
        put :update, { id: term.to_param, term: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested term' do
      term = Term.create! valid_attributes
      expect do
        delete :destroy, { id: term.to_param }, valid_session
      end.to change(Term, :count).by(-1)
    end

    it 'redirects to the terms list' do
      term = Term.create! valid_attributes
      delete :destroy, { id: term.to_param }, valid_session
      expect(response).to redirect_to(terms_url)
    end
  end
end
