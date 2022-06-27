# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'User Registration API' do
  context 'with valid registration params' do
    let(:user) { create(:user, :valid) }
    let(:login_params) do
      {
        user: { email: user.email, password: 'Alberto@1729' }
      }
    end

    path '/api/v1/users/sign_in' do
      post 'Registers a new user' do
        tags 'Login'
        consumes 'application/json'
        parameter name: :login_params, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string, example: Faker::Internet.email },
            password: { type: :string, example: Faker::Internet.password }
          },
          required: %w[email password]
        }

        response '200', 'registers a new user ' do
          produces 'application/json'
          schema(
            type: :object,
            properties: {
              done: { type: :boolean, example: true }
            }
          )
          it 'new user' do |example|
            submit_request(example.metadata)
            expect(response).to have_http_status(:ok)
          end
        end
      end
    end
  end
end
