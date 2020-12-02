# spec/requests/stacks_spec.rb
require 'rails_helper'

RSpec.describe 'Stacks API', type: :request do
  # initialize test data
  let!(:stacks) { create_list(:stack, 10) }
  let(:stack_id) { stacks.first.id }

  # Test suite for GET /stacks
  describe 'GET /stacks' do
    # make HTTP get request before each example
    before { get '/stacks' }

    it 'returns stacks' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /stacks/:id
  describe 'GET /stacks/:id' do
    before { get "/stacks/#{stack_id}" }

    context 'when the record exists' do
      it 'returns the stack' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq("#{stack_id}")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:stack_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stack/)
      end
    end
  end

  # Test suite for POST /stacks
  describe 'POST /stacks' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm'} }

    context 'when the request is valid' do
      before { post '/stacks', params: valid_attributes }

      it 'creates a stack' do
        expect(json['data']['attributes']['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/stacks', params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /stacks/:id
  describe 'PUT /stacks/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/stacks/#{stack_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /stacks/:id
  describe 'DELETE /stacks/:id' do
    before { delete "/stacks/#{stack_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end