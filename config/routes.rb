# frozen_string_literal: true

Rails.application.routes.draw do
  scope 'api/v1' do
    devise_for(
      :users,
      controllers: {
        sessions: 'api/v1/iam/sessions',
        registrations: 'api/v1/iam/registrations',
        confirmations: 'api/v1/confirmations',
        omniauth_callbacks: 'api/v1/iam/omniauth_callbacks',
        unlocks: 'api/v1/iam/unlocks',
        passwords: 'api/v1/iam/passwords'
      },
      defaults: { format: :json }
    )
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
