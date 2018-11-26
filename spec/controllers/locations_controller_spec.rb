# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'with an anonymous user' do
    let(:user) { nil }
    let(:location) { create(:location) }

    it 'should allow access to #show' do
      get :show, params: { id: location, library_id: location.library }
    end

    it 'should deny access to #new' do
      expect { get :new, params: { library_id: location.library } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #edit' do
      expect { get :edit, params:  { id: location, library_id: location.library } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #update' do
      expect { post :update, params: { id: location, library_id: location.library } }.to raise_error CanCan::AccessDenied
    end

    it 'should deny access to #destroy' do
      expect { delete :destroy, params: { id: location, library_id: location.library } }.to raise_error CanCan::AccessDenied
    end

    describe 'GET #hours_v1' do
      it 'assigns @when' do
        get :hours_v1, format: :json, params: { when: 'today', id: location, library_id: location.library }
        expect(assigns(:when)).to eq Time.zone.now.beginning_of_day
      end

      it 'assigns the hours for the location' do
        get :hours_v1, format: :json, params: { when: 'today', id: location, library_id: location.library }
        expect(assigns(:hours).first.first).to be_a MissingCalendar
        expect(assigns(:hours).first.first.dtstart).to eq Time.zone.now.beginning_of_day
      end
    end

    describe 'GET #hours' do
      it 'assigns @range from explicit dates' do
        get :hours, format: :json, params: { from: Time.zone.now.beginning_of_week.to_s, to: Time.zone.now.end_of_week.to_s, id: location, library_id: location.library }
        expect(assigns(:range).begin).to eq Time.zone.now.beginning_of_week.to_date
        expect(assigns(:range).end).to eq Time.zone.now.end_of_week.to_date
      end

      it 'assigns the hours for the location' do
        get :hours, format: :json, params: { id: location, library_id: location.library }
        expect(assigns(:hours).first.first).to be_a MissingCalendar
        expect(assigns(:hours).first.first.dtstart).to eq Time.zone.now.beginning_of_day
      end
    end
  end

  let(:user) { build(:superadmin_user) }

  let(:library) { create(:library) }

  let(:library_attributes) do
    { library_id: library }
  end

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: 'Some Location' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LocationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #show' do
    it 'assigns the requested location as @location' do
      location = library.locations.create! valid_attributes
      get :show, params: library_attributes.merge(id: location.to_param), session: valid_session
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'GET #new' do
    it 'assigns a new location as @location' do
      get :new, params: library_attributes, session: valid_session
      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested location as @location' do
      location = library.locations.create! valid_attributes
      get :edit, params: library_attributes.merge(id: location.to_param), session: valid_session
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Location' do
        expect do
          post :create, params: library_attributes.merge(location: valid_attributes), session: valid_session
        end.to change(Location, :count).by(1)
      end

      it 'assigns a newly created location as @location' do
        post :create, params: library_attributes.merge(location: valid_attributes), session: valid_session
        expect(assigns(:location)).to be_a(Location)
        expect(assigns(:location)).to be_persisted
      end

      it 'redirects to the created location' do
        post :create, params: library_attributes.merge(location: valid_attributes), session: valid_session
        expect(response).to redirect_to([library, Location.last])
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved location as @location' do
        post :create, params: library_attributes.merge(location: invalid_attributes), session: valid_session
        expect(assigns(:location)).to be_a_new(Location)
      end

      it "re-renders the 'new' template" do
        post :create, params: library_attributes.merge(location: invalid_attributes), session: valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'New Location Name' }
      end

      it 'updates the requested location' do
        location = library.locations.create! valid_attributes
        put :update, params: library_attributes.merge(id: location.to_param, location: new_attributes), session: valid_session
        location.reload
        expect(location.name).to eq 'New Location Name'
      end

      it 'assigns the requested location as @location' do
        location = library.locations.create! valid_attributes
        put :update, params: library_attributes.merge(id: location.to_param, location: valid_attributes), session: valid_session
        expect(assigns(:location)).to eq(location)
      end

      it 'redirects to the location' do
        location = library.locations.create! valid_attributes
        put :update, params: library_attributes.merge(id: location.to_param, location: valid_attributes), session: valid_session
        expect(response).to redirect_to([library, location])
      end
    end

    context 'with invalid params' do
      it 'assigns the location as @location' do
        location = library.locations.create! valid_attributes
        put :update, params: library_attributes.merge(id: location.to_param, location: invalid_attributes), session: valid_session
        expect(assigns(:location)).to eq(location)
      end

      it "re-renders the 'edit' template" do
        location = library.locations.create! valid_attributes
        put :update, params: library_attributes.merge(id: location.to_param, location: invalid_attributes), session: valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested location' do
      location = library.locations.create! valid_attributes
      expect do
        delete :destroy, params: library_attributes.merge(id: location.to_param), session: valid_session
      end.to change(Location, :count).by(-1)
    end

    it 'redirects to the locations list' do
      location = library.locations.create! valid_attributes
      delete :destroy, params: library_attributes.merge(id: location.to_param), session: valid_session
      expect(response).to redirect_to(library_url(location.library))
    end
  end
end
