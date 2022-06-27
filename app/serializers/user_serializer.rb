# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes(:id, :email)
  has_one :profile, key: :profile_attributes
end
