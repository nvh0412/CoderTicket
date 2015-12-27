require 'rails_helper'

describe TicketsController, type: :controller do
  let(:response_body) { response.body }
  let!(:event) { create(:event) }
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    context 'User has logged in' do
      it 'should be render new template' do
        get :new, event_id: event.id
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #index' do
    context "User have bought 1 ticket" do
      let!(:ticket) { create(:ticket, user: user) }
      let(:expected_result) { [ticket].to_json }
      it "should be return that ticket" do
        get :index, event_id: event.id, format: :json

        expect(response).to be_success
        expect(response_body).to eq expected_result
      end
    end

    context "User haven't bought any ticket" do
      it "should be return nothing" do
        get :index, event_id: event.id, format: :json

        expect(response).to be_success
        expect(JSON.parse(response_body)).to be_empty
      end
    end
  end

  describe 'POST #create' do
    let(:event) { create(:event) }
    let(:ticket_type) { create(:ticket_type, event: event) }

    context 'valid params' do
      let(:params) { { ticket: { quantity: ticket_type.max_quantity, ticket_type_id: ticket_type.id }, event_id: event.id } }

      it 'should be save this ticket and redirect to list of event page' do
        expect{ post :create, params }.to change{ Ticket.count }.by(1)
      end
    end

    context 'invalid params' do
      let(:params) { { ticket: { quantity: 10000 }, event_id: event.id } }

      it 'should be render template new' do
        post :create, params
        expect(response).to render_template(:new)
      end
    end

    context 'out of number of ticket of that event' do
      let(:params) { { ticket: { quantity: ticket_type.max_quantity + 1, ticket_type_id: ticket_type.id }, event_id: event.id } }

      it 'should not be save and render error message' do
        post :create, params
        expect(response).to render_template(:new)
      end
    end
  end

end
