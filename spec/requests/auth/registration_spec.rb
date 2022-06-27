# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'User Registration API' do
  context 'with valid registration params' do
    password = Faker::Internet.password
    let(:registration_params) do
      {
        sign_up: {
          email: Faker::Internet.email,
          password: password,
          password_confirmation: password,
          profile_attributes: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            phone_number: Faker::PhoneNumber.phone_number
          }
        }
      }
    end

    path '/api/v1/users' do
      post 'Registers a new user' do
        tags 'Registration'
        consumes 'application/json'
        parameter name: :registration_params, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string, example: Faker::Internet.email },
            password: { type: :string, example: password },
            password_confirmation: { type: :string, example: password },
            profile_attributes: {
              type: :object,
              properties: {
                first_name: { type: :string, example: Faker::Name.first_name },
                last_name: { type: :string, example: Faker::Name.first_name },
                phone_number: { type: :integer, example: Faker::PhoneNumber.phone_number }
              }
            }
          },
          required: %w[email password password_confirmation]
        }

        response '200', 'registers a new user ' do
          produces 'application/json'
          schema(
            type: :object,
            properties: {
              id: { type: :string, example: 1 },
              email: { type: :string, example: Faker::Internet.email },
              profile_attributes: {
                type: :object,
                properties: {
                  first_name: { type: :string, example: Faker::Name.first_name },
                  last_name: { type: :string, example: Faker::Name.first_name },
                  phone_number: { type: :integer, example: Faker::PhoneNumber.phone_number }
                }
              }
            }
          )
          it 'new user' do |example|
            submit_request(example.metadata)
            expect(response).to have_http_status(:ok)
            expect(User.count).to eq(1)
            expect(Profile.count).to eq(1)
            user = User.first
            profile = user.profile
            expect(json['email']).to eq(user.email)
            expect(json.dig(:profile_attributes, :first_name)).to eq(profile.first_name)
            expect(json.dig(:profile_attributes, :last_name)).to eq(profile.last_name)
            expect(json.dig(:profile_attributes, :phone_number)).to eq(profile.phone_number)
          end
        end
      end
    end
  end
end
