# frozen_string_literal: true

class ProfileSerializer < ApplicationSerializer
  attributes(
    :id,
    :first_name,
    :last_name,
    :phone_number
  )
end
