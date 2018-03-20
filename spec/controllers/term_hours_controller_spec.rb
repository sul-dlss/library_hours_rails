require 'rails_helper'

RSpec.describe TermHoursController, type: :controller do
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'with an anonymous user' do
    let(:user) { nil }
    let(:term_hour) { create(:term_hour) }

    it 'should deny access to #show' do
      expect { get :show, params: { id: term_hour, library_id: term_hour.library, location_id: term_hour.location } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #new' do
      expect { get :new, params: { library_id: term_hour.library, location_id: term_hour.location } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #edit' do
      expect { get :edit, params: { id: term_hour, library_id: term_hour.library, location_id: term_hour.location } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #update' do
      expect { post :update, params: { id: term_hour, library_id: term_hour.library, location_id: term_hour.location } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #destroy' do
      expect { delete :destroy, params: { id: term_hour, library_id: term_hour.library, location_id: term_hour.location } }.to raise_error CanCan::AccessDenied
    end
  end

  let(:user) { build(:superadmin_user) }
  let(:location) { create(:location) }
  let(:library) { location.library }
  let(:term) { create(:term) }

  # This should return the minimal set of attributes required to create a valid
  # TermHour. As you add validations to TermHour, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { term_id: term.id, location_id: location.id, monday: '9a-5p' }
  end

  let(:invalid_attributes) do
    { monday: 'who knows' }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TermHoursController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all term_hours as @term_hours' do
      get :index, params: { library_id: library, location_id: location }, session: valid_session
      expect(assigns(:library)).to eq(library)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested term_hour as @term_hour' do
      term_hour = TermHour.create! valid_attributes
      get :show, params: { id: term_hour.to_param, library_id: library, location_id: location }, session: valid_session
      expect(assigns(:term_hour)).to eq(term_hour)
    end
  end

  describe 'GET #new' do
    it 'assigns a new term_hour as @term_hour' do
      get :new, params: { library_id: library, location_id: location }, session: valid_session
      expect(assigns(:term_hour)).to be_a_new(TermHour)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested term_hour as @term_hour' do
      term_hour = TermHour.create! valid_attributes
      get :edit, params: { id: term_hour.to_param, library_id: library, location_id: location }, session: valid_session
      expect(assigns(:term_hour)).to eq(term_hour)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new TermHour' do
        expect do
          post :create, params: { term: term, term_hour: valid_attributes, library_id: library, location_id: location }, session: valid_session
        end.to change(TermHour, :count).by(1)
      end

      it 'assigns a newly created term_hour as @term_hour' do
        post :create, params: { term: term, term_hour: valid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(assigns(:term_hour)).to be_a(TermHour)
        expect(assigns(:term_hour)).to be_persisted
      end

      it 'redirects to the created term_hour' do
        post :create, params: { term: term, term_hour: valid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(response).to redirect_to(library_location_term_hours_path(library, location))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved term_hour as @term_hour' do
        post :create, params: { term: term, term_hour: invalid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(assigns(:term_hour)).to be_a_new(TermHour)
      end

      it "re-renders the 'new' template" do
        post :create, params: { term: term, term_hour: invalid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { monday: 'closed' }
      end

      it 'updates the requested term_hour' do
        term_hour = TermHour.create! valid_attributes
        put :update, params: { id: term_hour.to_param, term_hour: new_attributes, library_id: library, location_id: location }, session: valid_session
        term_hour.reload
        expect(term_hour.monday).to eq 'closed'
      end

      it 'assigns the requested term_hour as @term_hour' do
        term_hour = TermHour.create! valid_attributes
        put :update, params: { id: term_hour.to_param, term_hour: valid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(assigns(:term_hour)).to eq(term_hour)
      end

      it 'redirects to the term_hour' do
        term_hour = TermHour.create! valid_attributes
        put :update, params: { id: term_hour.to_param, term_hour: valid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(response).to redirect_to(library_location_term_hours_path(library, location))
      end
    end

    context 'with invalid params' do
      it 'assigns the term_hour as @term_hour' do
        term_hour = TermHour.create! valid_attributes
        put :update, params: { id: term_hour.to_param, term_hour: invalid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(assigns(:term_hour)).to eq(term_hour)
      end

      it "re-renders the 'edit' template" do
        term_hour = TermHour.create! valid_attributes
        put :update, params: { id: term_hour.to_param, term_hour: invalid_attributes, library_id: library, location_id: location }, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested term_hour' do
      term_hour = TermHour.create! valid_attributes
      expect do
        delete :destroy, params: { id: term_hour.to_param, library_id: library, location_id: location }, session: valid_session
      end.to change(TermHour, :count).by(-1)
    end

    it 'redirects to the term_hours list' do
      term_hour = TermHour.create! valid_attributes
      delete :destroy, params: { id: term_hour.to_param, library_id: library, location_id: location }, session: valid_session
      expect(response).to redirect_to(library_location_term_hours_path(library, location))
    end
  end
end
