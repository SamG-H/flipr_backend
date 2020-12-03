require 'rails_helper'

RSpec.describe 'scores API' do
  # Initialize the test data
  let!(:stack) { create(:stack) }
  let!(:scores) { create_list(:score, 20, stack_id: stack.id) }
  let(:stack_id) { stack.id }
  let(:id) { scores.first.id }

  # Test suite for GET /stacks/:stack_id/scores
  describe 'GET /stacks/:stack_id/scores' do
    before { get "/stacks/#{stack_id}/scores" }

    context 'when stack exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all stack scores' do
        expect(json['data'].size).to eq(20)
      end
    end

    context 'when stack does not exist' do
      let(:stack_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stack/)
      end
    end
  end

  # Test suite for GET /stacks/:stack_id/scores/:id
  describe 'GET /stacks/:stack_id/scores/:id' do
    before { get "/stacks/#{stack_id}/scores/#{id}" }

    context 'when stack score exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the score' do
        expect(json['data']['id']).to eq("#{id}")
      end
    end

    context 'when stack score does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Score/)
      end
    end
  end

  # Test suite for PUT /stacks/:stack_id/scores
  describe 'POST /stacks/:stack_id/scores' do
    let(:valid_attributes) { { name: 'Visit Narnia', percentage: 100 } }

    context 'when request attributes are valid' do
      before { post "/stacks/#{stack_id}/scores", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/stacks/#{stack_id}/scores", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /stacks/:stack_id/scores/:id
  describe 'PUT /stacks/:stack_id/scores/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/stacks/#{stack_id}/scores/#{id}", params: valid_attributes }

    context 'when score exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the score' do
        updated_score = Score.find(id)
        expect(updated_score.name).to match(/Mozart/)
      end
    end

    context 'when the score does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Score/)
      end
    end
  end

  # Test suite for DELETE /stacks/:id
  describe 'DELETE /stacks/:id' do
    before { delete "/stacks/#{stack_id}/scores/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end