require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'with an anonymous user' do
    let(:user) { nil }
    let(:library) { create(:library) }

    it 'should allow access to #index' do
      get :index
    end

    it 'should allow access to #show' do
      get :show, id: library
    end

    it 'should deny access to #new' do
      expect { get :new }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #edit' do
      expect { get :edit, id: library }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #update' do
      expect { post :update, id: library }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #destroy' do
      expect { delete :destroy, id: library }.to raise_error CanCan::AccessDenied
    end
  end

  let(:user) { build(:superadmin_user) }

  # This should return the minimal set of attributes required to create a valid
  # Library. As you add validations to Library, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: 'Some New Library' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LibrariesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all libraries as @libraries' do
      library = Library.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:libraries)).to eq([library])
    end

    describe '@range' do
      it 'defaults to the current week' do
        get :index, {}, valid_session
        expect(assigns(:range)).to eq(Time.zone.today.beginning_of_week(:sunday).to_date..(Time.zone.today.end_of_week(:sunday).to_date))
      end

      it 'assigns using the given week' do
        get :index, { week: '2015W1' }, valid_session
        expect(assigns(:range)).to eq(Calendar.week('2015W1'))
      end

      it 'assigns using the given time' do
        get :index, { when: '2015-04-05' }, valid_session
        expect(assigns(:range)).to eq(Date.parse('2015-04-05')..Date.parse('2015-04-05'))
      end

      it 'assigns using from/to' do
        get :index, { from: '2015-02-03', to: '2015-03-02' }, valid_session
        expect(assigns(:range)).to eq(Date.parse('2015-02-03')..Date.parse('2015-03-02'))
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested library as @library' do
      library = Library.create! valid_attributes
      get :show, { id: library.to_param }, valid_session
      expect(assigns(:library)).to eq(library)
    end

    it 'assigns the current range to @range' do
      get :index, {}, valid_session
      expect(assigns(:range)).to eq(Time.zone.today.beginning_of_week(:sunday)..(Time.zone.today.end_of_week(:sunday)))
    end
  end

  describe 'GET #new' do
    it 'assigns a new library as @library' do
      get :new, {}, valid_session
      expect(assigns(:library)).to be_a_new(Library)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested library as @library' do
      library = Library.create! valid_attributes
      get :edit, { id: library.to_param }, valid_session
      expect(assigns(:library)).to eq(library)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Library' do
        expect do
          post :create, { library: valid_attributes }, valid_session
        end.to change(Library, :count).by(1)
      end

      it 'assigns a newly created library as @library' do
        post :create, { library: valid_attributes }, valid_session
        expect(assigns(:library)).to be_a(Library)
        expect(assigns(:library)).to be_persisted
      end

      it 'redirects to the created library' do
        post :create, { library: valid_attributes }, valid_session
        expect(response).to redirect_to(Library.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved library as @library' do
        post :create, { library: invalid_attributes }, valid_session
        expect(assigns(:library)).to be_a_new(Library)
      end

      it "re-renders the 'new' template" do
        post :create, { library: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Renamed Library' }
      end

      it 'updates the requested library' do
        library = Library.create! valid_attributes
        put :update, { id: library.to_param, library: new_attributes }, valid_session
        library.reload
        expect(library.name).to eq 'Renamed Library'
      end

      it 'assigns the requested library as @library' do
        library = Library.create! valid_attributes
        put :update, { id: library.to_param, library: valid_attributes }, valid_session
        expect(assigns(:library)).to eq(library)
      end

      it 'redirects to the library' do
        library = Library.create! valid_attributes
        put :update, { id: library.to_param, library: valid_attributes }, valid_session
        expect(response).to redirect_to(library)
      end
    end

    context 'with invalid params' do
      it 'assigns the library as @library' do
        library = Library.create! valid_attributes
        put :update, { id: library.to_param, library: invalid_attributes }, valid_session
        expect(assigns(:library)).to eq(library)
      end

      it "re-renders the 'edit' template" do
        library = Library.create! valid_attributes
        put :update, { id: library.to_param, library: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested library' do
      library = Library.create! valid_attributes
      expect do
        delete :destroy, { id: library.to_param }, valid_session
      end.to change(Library, :count).by(-1)
    end

    it 'redirects to the libraries list' do
      library = Library.create! valid_attributes
      delete :destroy, { id: library.to_param }, valid_session
      expect(response).to redirect_to(libraries_url)
    end
  end
end
