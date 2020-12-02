require 'rails_helper'

RSpec.describe 'cards API' do
  # Initialize the test data
  let!(:stack) { create(:stack) }
  let!(:cards) { create_list(:card, 20, stack_id: stack.id) }
  let(:stack_id) { stack.id }
  let(:id) { cards.first.id }

  # Test suite for GET /stacks/:stack_id/cards
  describe 'GET /stacks/:stack_id/cards' do
    before { get "/stacks/#{stack_id}/cards" }

    context 'when stack exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all stack cards' do
        expect(json.size).to eq(20)
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

  # Test suite for GET /stacks/:stack_id/cards/:id
  describe 'GET /stacks/:stack_id/cards/:id' do
    before { get "/stacks/#{stack_id}/cards/#{id}" }

    context 'when stack card exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the card' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when stack card does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Card/)
      end
    end
  end

  # Test suite for PUT /stacks/:stack_id/cards
  describe 'POST /stacks/:stack_id/cards' do
    let(:valid_attributes) { { front: 'Visit Narnia', back: 'Book' } }

    context 'when request attributes are valid' do
      before { post "/stacks/#{stack_id}/cards", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/stacks/#{stack_id}/cards", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Front can't be blank/)
      end
    end
  end

  # Test suite for PUT /stacks/:stack_id/cards/:id
  describe 'PUT /stacks/:stack_id/cards/:id' do
    let(:valid_attributes) { { front: 'Mozart' } }

    before { put "/stacks/#{stack_id}/cards/#{id}", params: valid_attributes }

    context 'when card exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the card' do
        updated_card = Card.find(id)
        expect(updated_card.front).to match(/Mozart/)
      end
    end

    context 'when the card does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Card/)
      end
    end
  end

  # Test suite for DELETE /stacks/:id
  describe 'DELETE /stacks/:id' do
    before { delete "/stacks/#{stack_id}/cards/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end