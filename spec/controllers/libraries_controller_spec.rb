# frozen_string_literal: true

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
      get :show, params: { id: library }
    end

    it 'should deny access to #new' do
      expect { get :new }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #edit' do
      expect { get :edit, params: { id: library } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #update' do
      expect { post :update, params: { id: library } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #destroy' do
      expect { delete :destroy, params: { id: library } }.to raise_error CanCan::AccessDenied
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
      library.locations << create(:location, keeps_hours: true)
      get :index, params: {}, session: valid_session
      expect(assigns(:libraries)).to eq([library])
    end

    it 'sorts the libraries by the sort_key' do
      library1 = Library.create!(valid_attributes).tap { |lib| lib.locations << create(:location, keeps_hours: true) }
      library2 = Library.create!(name: 'Another New library').tap { |lib| lib.locations << create(:location, keeps_hours: true) }
      library3 = Library.create!(name: 'Yet Another New library', slug: 'green').tap { |lib| lib.locations << create(:location, keeps_hours: true) }

      get :index, params: {}, session: valid_session
      libraries = assigns(:libraries)
      expect(libraries[0].id).to eq library3.id
      expect(libraries[1].id).to eq library2.id
      expect(libraries[2].id).to eq library1.id
    end

    describe '@range' do
      let(:year) { Time.zone.now.year }
      it 'defaults to the current week' do
        get :index, params: {}, session: valid_session
        expect(assigns(:range)).to eq(Time.zone.today.beginning_of_week(:sunday).to_date..(Time.zone.today.end_of_week(:sunday).to_date))
      end

      it 'assigns using the given week' do
        get :index, params: { week: "#{year}W1" }, session: valid_session
        expect(assigns(:range)).to eq(Calendar.week("#{year}W1"))
      end

      it 'assigns using the given time' do
        get :index, params: { when: "#{year}-04-05" }, session: valid_session
        expect(assigns(:range)).to eq(Date.parse("#{year}-04-05")..Date.parse("#{year}-04-05"))
      end

      it 'assigns using from/to' do
        get :index, params: { from: "#{year}-02-03", to: "#{year}-03-02" }, session: valid_session
        expect(assigns(:range)).to eq(Date.parse("#{year}-02-03")..Date.parse("#{year}-03-02"))
      end

      it 'assigns using from' do
        get :index, params: { from: "#{year}-02-03" }, session: valid_session
        expect(assigns(:range)).to eq(Date.parse("#{year}-02-03")..Date.parse("#{year}-02-03"))
      end

      it 'assigns using from' do
        get :index, params: { date: "#{year}-09-18" }, session: valid_session
        expect(subject).to redirect_to "http://test.host/?week=#{year}W38"
      end

      it 'restricts the range to an 18 month period' do
        expect do
          get :index, params: { from: "#{year}-02-03", to: "#{year+4}-03-02" }, session: valid_session
        end.to raise_error(ActionController::BadRequest)
      end

      it 'restricts the beginning of the range to an 48 month period' do
        expect do
          get :index, params: { from: "#{year-5}-02-03", to: "#{year-5}-03-02" }, session: valid_session
        end.to raise_error(ActionController::BadRequest)
      end

      it 'restricts the end of the range to an 24 month period' do
        expect do
          get :index, params: { from: "#{year+3}-02-03", to: "#{year+3}-03-02" }, session: valid_session
        end.to raise_error(ActionController::BadRequest)
      end
    end

    describe 'format' do
      it 'exports a CSV' do
        get :index, params: { format: :csv }, session: valid_session
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested library as @library' do
      library = Library.create! valid_attributes
      get :show, params: { id: library.to_param }, session: valid_session
      expect(assigns(:library)).to eq(library)
    end

    it 'assigns the current range to @range' do
      get :index, params: {}, session: valid_session
      expect(assigns(:range)).to eq(Time.zone.today.beginning_of_week(:sunday)..(Time.zone.today.end_of_week(:sunday)))
    end
  end

  describe 'GET #new' do
    it 'assigns a new library as @library' do
      get :new, params: {}, session: valid_session
      expect(assigns(:library)).to be_a_new(Library)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested library as @library' do
      library = Library.create! valid_attributes
      get :edit, params: { id: library.to_param }, session: valid_session
      expect(assigns(:library)).to eq(library)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Library' do
        expect do
          post :create, params: { library: valid_attributes }, session: valid_session
        end.to change(Library, :count).by(1)
      end

      it 'assigns a newly created library as @library' do
        post :create, params: { library: valid_attributes }, session: valid_session
        expect(assigns(:library)).to be_a(Library)
        expect(assigns(:library)).to be_persisted
      end

      it 'redirects to the created library' do
        post :create, params: { library: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Library.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved library as @library' do
        post :create, params: { library: invalid_attributes }, session: valid_session
        expect(assigns(:library)).to be_a_new(Library)
      end

      it "re-renders the 'new' template" do
        post :create, params: { library: invalid_attributes }, session: valid_session
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
        put :update, params: { id: library.to_param, library: new_attributes }, session: valid_session
        library.reload
        expect(library.name).to eq 'Renamed Library'
      end

      it 'assigns the requested library as @library' do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: valid_attributes }, session: valid_session
        expect(assigns(:library)).to eq(library)
      end

      it 'redirects to the library' do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: valid_attributes }, session: valid_session
        expect(response).to redirect_to(library)
      end
    end

    context 'with invalid params' do
      it 'assigns the library as @library' do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: invalid_attributes }, session: valid_session
        expect(assigns(:library)).to eq(library)
      end

      it "re-renders the 'edit' template" do
        library = Library.create! valid_attributes
        put :update, params: { id: library.to_param, library: invalid_attributes }, session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested library' do
      library = Library.create! valid_attributes
      expect do
        delete :destroy, params: { id: library.to_param }, session: valid_session
      end.to change(Library, :count).by(-1)
    end

    it 'redirects to the libraries list' do
      library = Library.create! valid_attributes
      delete :destroy, params: { id: library.to_param }, session: valid_session
      expect(response).to redirect_to(libraries_url)
    end
  end
end
