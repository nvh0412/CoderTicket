require 'rails_helper'

describe EventsController, type: :controller do
  let(:response_body) { response.body }
  let!(:category) { create(:category) }
  let!(:venue) { create(:venue) }

  describe "GET index" do
    context "Past events" do
      let(:events) { create_list(:event, 3, :past) }

      it "should not be returned" do
        get :index
        expect(response).to be_success
        expect(response_body).to be_empty
      end
    end

    context "Future and current events" do
      let!(:events) { create_list(:event, 1, :up_comming, category: category, venue: venue) }
      let(:expected_result) { events.to_json }

      it "should be returned" do
        get :index, format: :json
        expect(response).to be_success
        expect(response_body).to eq expected_result
      end
    end
  end

  describe "POST create" do
    let!(:event) { build(:event, category: category, venue: venue) }
    let!(:user) { create(:user) }

    context "User haven't logged in" do
      it "should be redirect to login page" do
        post :create, event: event
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "User has logged in" do
      before do
        sign_in user
      end

      context "valid params" do
        let(:params) { {
          event: {
            name: event.name,
            starts_at: event.starts_at,
            ends_at: event.ends_at,
            hero_image_url: event.hero_image_url,
            venue_id: event.venue_id,
            category_id: event.category_id,
            extended_html_description: event.extended_html_description
          }
        } }

        it "shoud be save event and redirect to event index page" do
          expect{ post :create, params }.to change{ Event.count }.by(1)
          expect(response).to redirect_to(events_path);
        end
      end

      context "invalid params" do
        let(:params) { { event: { name: 'invalid name' } } }
        it "shouldn't be save event and render new event page" do
          post :create, params
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET #new' do
    let!(:user) { create(:user) }

    context "User has't logged in" do
      it "should be redirect to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'User has logged in' do
      before do
        sign_in user
      end

      it "should be render new template" do
        get :new
        expect(response).to be_success
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    context 'event has been expired' do
      let(:event) { create(:event, :past) }
      it 'should be return empty result' do
        get :show, id: event.id
        expect(response).to be_success
        expect(response_body).to be_empty
      end
    end

    context 'event still valid' do
      let!(:event) { create(:event, :up_comming) }
      let(:expected_result) { event.to_json }
      it 'should be return event' do
        get :show, id: event.id, format: :json
        expect(response).to be_success
        expect(response_body).to eq expected_result
      end
    end
  end

end
