require 'rails_helper'

RSpec.describe PrioritiesController, type: :controller do

  login_user

  describe 'POST /priorities' do
    context 'when params are valid.' do

      before do
        post :create, params: { priority: { status: 'high' } }
      end

      it 'should return status code 201.' do
        expect(response).to have_http_status(201)
      end
      it 'should return created priority.' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:status]).to eq('high')
      end
    end
    context 'when params are invalid.' do
      it 'should return error message.' do
        post :create, params: { priority: { status: nil } }
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:message]).to eq("Status can't be blank")
      end
    end
  end

  describe 'GET /priorities' do
    context 'when call to action index.' do
      it "should return all priorities." do
        get :index
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result.count).to eq(Priority.count)
      end
    end
  end

  describe 'PUT /priorities/:id' do
    context 'when params are valid.' do

      before do
        priority = create(:priority)
        put :update, params: { priority: { status: 'low' }, id: priority.id }
      end

      it 'should return status code 200.' do
        expect(response).to have_http_status(200)
      end
      it 'should return updated priority.' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:status]).to eq('low')
      end
    end
    context 'when params are invalid.' do

      before do
        priority = create(:priority)
        put :update, params: { priority: { status: nil }, id: priority.id }
      end

      it 'should return status code 417.' do
        expect(response).to have_http_status(417)
      end
      it 'should return a error message' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:message]).to eq("Status can't be blank")
      end
    end
  end

  describe 'DELETE /priorities/:id' do
    context 'when params are valid.' do

      before do
        priority = create(:priority)
        delete :destroy, params: { id: priority.id }
      end

      it 'should return status code 200.' do
        expect(response).to have_http_status(200)
      end
      it "should return a hash with deleted priority attributes." do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:status]).to eq('high')
      end
    end
    context 'when params are invalid.' do

      before do
        delete :destroy, params: { id: 1000 }
      end

      it 'should return error message.' do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:message]).to eq('Priority not found.')
      end
      it 'should return status 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
