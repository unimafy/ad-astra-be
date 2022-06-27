# frozen_string_literal: true

module Auth
  class Register < Base
    def run
      create_user
    end

    private

    def create_user
      User.create!(params)
    end
  end
end
